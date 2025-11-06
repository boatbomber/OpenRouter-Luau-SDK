"""
Code Generator for the OpenRouter Luau SDK Generator.

Generates Luau type definitions and SDK methods from parsed OpenAPI specifications.
"""

import logging
import shutil
import subprocess
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Dict, List, Optional

from jinja2 import Environment, FileSystemLoader, select_autoescape

from generator.parser import Operation, ParsedSpec
from generator.type_converter import TypeConverter
from generator.utils import (
    camel_case,
    ensure_directory,
    format_comment,
    get_generation_header,
    indent_text,
    topological_sort,
)

logger = logging.getLogger("generator")


@dataclass
class TypeDefinition:
    """Represents a Luau type definition."""

    name: str
    type: str
    code: Optional[int] = None
    description: Optional[str] = None


@dataclass
class MethodDefinition:
    """Represents a Luau method definition."""

    name: str
    http_method: str
    path: str
    params: str
    return_type: str
    body_param: str
    description: Optional[str] = None
    body: Optional[str] = None
    has_path_vars: bool = False
    has_query_params: bool = False
    query_params: Optional[List[str]] = None


class CodeGenerator:
    """
    Generates Luau code from a parsed OpenAPI specification.

    Creates type definitions and SDK method signatures.
    """

    def __init__(self, spec: ParsedSpec, output_dir: Path, parser: Any):
        """
        Initialize the code generator.

        Args:
            spec: Parsed OpenAPI specification
            output_dir: Output directory for generated files
            parser: OpenAPIParser instance for reference resolution
        """
        self.spec = spec
        self.output_dir = output_dir
        self.generated_dir = output_dir
        self.parser = parser

        # Set up Jinja2 environment
        template_dir = Path(__file__).parent / "templates"
        self.jinja_env = Environment(
            loader=FileSystemLoader(template_dir),
            autoescape=select_autoescape(),
            trim_blocks=True,
            lstrip_blocks=True,
        )

        # Add custom filters
        self.jinja_env.filters["format_comment"] = format_comment
        self.jinja_env.filters["indent"] = indent_text

        # Create type converter with parser
        self.type_converter = TypeConverter(parser)

    def generate(self) -> List[Path]:
        """
        Generate all Luau files.

        Returns:
            List of generated file paths

        Raises:
            Exception: If generation fails
        """
        ensure_directory(self.generated_dir)

        generated_files = []

        # Generate types
        logger.info("Generating types...")
        types_file = self._generate_types()
        generated_files.append(types_file)

        # Generate methods
        logger.info("Generating methods...")
        methods_file = self._generate_methods()
        generated_files.append(methods_file)

        # Format generated files with stylua
        logger.info("Formatting generated files with stylua...")
        self._format_files(generated_files)

        return generated_files

    def _generate_types(self) -> Path:
        """
        Generate types.luau file.

        Returns:
            Path to generated file
        """
        # Build type definitions
        type_defs = []

        # Get schema dependencies for ordering
        from generator.parser import OpenAPIParser

        # Create a simple dependency graph
        dependencies: Dict[str, List[str]] = {}
        for name, schema in self.spec.schemas.items():
            dependencies[name] = self._get_type_dependencies(schema)

        # Sort schemas topologically
        try:
            sorted_names = topological_sort(dependencies)
        except ValueError as e:
            logger.warning(f"Circular dependencies detected: {e}")
            # Fall back to alphabetical order
            sorted_names = sorted(self.spec.schemas.keys())

        # Generate type definitions in order
        for name in sorted_names:
            schema = self.spec.schemas[name]
            type_def = self._create_type_definition(name, schema)
            if type_def:
                type_defs.append(type_def)

        # Generate response types for operations
        for operation in self.spec.operations:
            response_types = self._create_response_types(operation)
            if response_types:
                type_defs.extend(response_types)

        # Render template
        template = self.jinja_env.get_template("types.luau.j2")
        content = template.render(
            header=get_generation_header(str(self.spec.title)),
            description=self.spec.description,
            types=type_defs,
            format_comment=format_comment,
        )

        # Write file
        output_path = self.generated_dir / "types.luau"
        output_path.write_text(content, encoding="utf-8")
        logger.info(f"Generated {len(type_defs)} types")

        return output_path

    def _generate_methods(self) -> Path:
        """
        Generate methods.luau file.

        Returns:
            Path to generated file
        """
        # Build method definitions
        method_defs = []

        for operation in self.spec.operations:
            method_def = self._create_method_definition(operation)
            if method_def:
                method_defs.append(method_def)

        # Render template
        template = self.jinja_env.get_template("methods.luau.j2")
        content = template.render(
            header=get_generation_header(str(self.spec.title)),
            description=f"{self.spec.title} - Generated API Methods",
            methods=method_defs,
            format_comment=format_comment,
        )

        # Write file
        output_path = self.generated_dir / "init.luau"
        output_path.write_text(content, encoding="utf-8")
        logger.info(f"Generated {len(method_defs)} methods")

        return output_path

    def _create_type_definition(
        self, name: str, schema: Any
    ) -> Optional[TypeDefinition]:
        """
        Create a type definition from a schema.

        Args:
            name: Schema name
            schema: Schema object

        Returns:
            TypeDefinition or None
        """
        # Convert schema to Luau type
        luau_type = self.type_converter.convert_schema(schema, name)

        # Get description
        description = getattr(schema, "description", None)

        return TypeDefinition(name=name, type=luau_type, description=description)

    def _create_response_types(
        self, operation: Operation
    ) -> Optional[List[TypeDefinition]]:
        """
        Create a response type definition for an operation.

        Args:
            operation: Operation object

        Returns:
            List of TypeDefinition for the possible response codes, or None if no response schema is found
        """
        response_schemas: Dict[int, Any] = {
            int(status_code): response["schema"]
            for status_code, response in operation.responses.items()
            if response and response.get("schema")
        }
        if not response_schemas:
            return None

        response_types = []
        for status_code, response_schema in response_schemas.items():
            # Generate type name from operation ID (e.g., getUserActivity -> GetUserActivity200Response)
            type_name = (
                operation.operation_id[0].upper()
                + operation.operation_id[1:]
                + f"{status_code}Response"
            )

            # Convert schema to Luau type
            luau_type = self.type_converter.convert_schema(response_schema)

            # Get description from response
            description = f"{status_code} Response type for {operation.operation_id}"

            response_types.append(
                TypeDefinition(
                    name=type_name,
                    type=luau_type,
                    code=status_code,
                    description=description,
                )
            )

        return response_types

    def _create_method_definition(
        self, operation: Operation
    ) -> Optional[MethodDefinition]:
        """
        Create a method definition from an operation.

        Args:
            operation: Operation object

        Returns:
            MethodDefinition or None
        """
        # Use operation ID as method name (already in camelCase)
        method_name = operation.operation_id

        # Build parameter list
        params_list = []
        query_param_names = []

        # Collect and sort parameters: required first, then optional
        param_info = []
        for param in operation.parameters:
            param_name = getattr(param, "name", "param")
            param_in = getattr(
                param, "param_in", getattr(param, "in_", "query")
            )  # Try param_in or in_
            param_required = getattr(param, "required", False)
            param_type = self.type_converter.convert_parameter_type(param)
            # Prefix custom types with Types.
            param_type = self._prefix_types_with_namespace(param_type)

            # Make optional parameters nullable
            if not param_required and not param_type.endswith("?"):
                param_type += "?"

            param_info.append(
                {
                    "name": param_name,
                    "type": param_type,
                    "in": param_in,
                    "required": param_required,
                }
            )

            # Track query parameters
            if param_in == "query":
                query_param_names.append(param_name)

        # Sort parameters: required first, then optional
        param_info.sort(key=lambda p: (not p["required"], p["name"]))

        # Build parameter list
        for param in param_info:
            params_list.append(f"{param['name']}: {param['type']}")

        # Add request body parameter
        body_param = "nil"
        if operation.request_body:
            request_schema = operation.request_body.get("schema")
            if request_schema:
                # Get the type for the request body
                body_type = self.type_converter.convert_schema(request_schema)
                # Prefix custom types with Types.
                body_type = self._prefix_types_with_namespace(body_type)
                params_list.append(f"params: {body_type}")
                body_param = "params"

        params = ", ".join(params_list) if params_list else ""

        # Determine return type - use the named response type
        return_type = "any"
        response_types = self._create_response_types(operation)
        if response_types:
            success_types = [
                f"Types.{response_type.name}"
                for response_type in response_types
                if response_type.code >= 200 and response_type.code < 300
            ]
            error_types = [
                f"Types.{response_type.name}"
                for response_type in response_types
                if response_type.code < 200 or response_type.code >= 300
            ]
            return_type = (
                f"Types.Result<{' | '.join(success_types)}, {' | '.join(error_types)}>"
            )

        # Build description
        description_parts = []
        if operation.summary:
            description_parts.append(operation.summary)
        if operation.description:
            description_parts.append(operation.description)

        description_parts.append(
            f"\nEndpoint: {operation.method.upper()} {operation.path}"
        )

        description = "\n\n".join(description_parts) if description_parts else None

        # Check if path contains variables (e.g., {hash})
        has_path_vars = "{" in operation.path and "}" in operation.path
        has_query_params = len(query_param_names) > 0

        return MethodDefinition(
            name=method_name,
            http_method=operation.method.upper(),
            path=operation.path,
            params=params,
            return_type=return_type,
            body_param=body_param,
            description=description,
            has_path_vars=has_path_vars,
            has_query_params=has_query_params,
            query_params=query_param_names if has_query_params else None,
        )

    def _get_type_dependencies(self, schema: Any) -> List[str]:
        """
        Get type dependencies for a schema.

        Args:
            schema: Schema object

        Returns:
            List of schema names this schema depends on
        """
        dependencies = []

        # Handle references
        if hasattr(schema, "ref") and schema.ref:
            ref_name = schema.ref.split("/")[-1]
            if ref_name:
                dependencies.append(ref_name)

        # Handle properties
        if hasattr(schema, "properties") and schema.properties:
            for prop_schema in schema.properties.values():
                dependencies.extend(self._get_type_dependencies(prop_schema))

        # Handle items (for arrays)
        if hasattr(schema, "items") and schema.items:
            dependencies.extend(self._get_type_dependencies(schema.items))

        # Handle allOf
        if hasattr(schema, "allOf") and schema.allOf:
            for sub_schema in schema.allOf:
                dependencies.extend(self._get_type_dependencies(sub_schema))

        # Handle anyOf
        if hasattr(schema, "anyOf") and schema.anyOf:
            for sub_schema in schema.anyOf:
                dependencies.extend(self._get_type_dependencies(sub_schema))

        # Handle oneOf
        if hasattr(schema, "oneOf") and schema.oneOf:
            for sub_schema in schema.oneOf:
                dependencies.extend(self._get_type_dependencies(sub_schema))

        # Remove duplicates and return
        return list(set(dependencies))

    def _prefix_types_with_namespace(
        self, type_str: str, namespace: str = "Types"
    ) -> str:
        """
        Prefix custom type names with namespace (e.g., Types.TypeName).

        Args:
            type_str: Type string to process
            namespace: Namespace prefix to add (default: "Types")

        Returns:
            Type string with custom types prefixed
        """
        # Primitive types that should not be prefixed
        primitives = {"string", "number", "boolean", "nil", "any", "never"}

        # If the type is a primitive, return as-is
        if type_str in primitives:
            return type_str

        # Replace custom type names with prefixed versions
        # This is a simple approach - we'll replace word boundaries
        import re

        def replace_type_name(match):
            type_name = match.group(0)
            # Don't prefix primitives or already-prefixed types
            if type_name in primitives or type_name.startswith(f"{namespace}."):
                return type_name
            # Check if it's likely a type name (PascalCase)
            if type_name[0].isupper():
                return f"{namespace}.{type_name}"
            return type_name

        # Match type names (alphanumeric starting with uppercase, followed by word boundary)
        result = re.sub(r"\b[A-Z][a-zA-Z0-9_]*\b", replace_type_name, type_str)
        return result

    def _format_files(self, files: List[Path]) -> None:
        """
        Format generated files using stylua.

        Args:
            files: List of file paths to format
        """
        # Check if stylua is available
        stylua_path = shutil.which("stylua")
        if not stylua_path:
            logger.warning("stylua not found in PATH, skipping formatting")
            return

        for file_path in files:
            try:
                # Run stylua on the file
                result = subprocess.run(
                    [stylua_path, str(file_path)],
                    capture_output=True,
                    text=True,
                    timeout=30,
                )

                if result.returncode == 0:
                    logger.debug(f"Formatted {file_path.name}")
                else:
                    logger.warning(
                        f"stylua failed for {file_path.name}: {result.stderr}"
                    )

            except subprocess.TimeoutExpired:
                logger.warning(f"stylua timed out for {file_path.name}")
            except Exception as e:
                logger.warning(f"Failed to format {file_path.name}: {e}")

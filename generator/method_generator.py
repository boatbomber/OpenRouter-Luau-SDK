"""
Method Generator for the OpenRouter Luau SDK Generator.

Generates Luau method definitions from OpenAPI operations.
"""

import logging
from dataclasses import dataclass
from typing import Any, Dict, List, Optional

from generator.parser import Operation, ParsedSpec
from generator.schema_resolver import SchemaResolver
from generator.type_converter import TypeConverter
from generator.type_generator import TypeGenerator

logger = logging.getLogger("generator")


@dataclass
class MethodDefinition:
    """Represents a Luau method definition."""

    name: str
    http_method: str
    path: str
    params: str
    return_type: str
    body_param: str
    doc_string: Optional[str] = None
    body: Optional[str] = None
    has_path_vars: bool = False
    has_query_params: bool = False
    query_params: Optional[List[str]] = None
    tags: List[str] = None


class MethodGenerator:
    """
    Generates Luau method definitions from OpenAPI operations.

    Handles parameter extraction, return type building, and documentation.
    """

    def __init__(
        self,
        spec: ParsedSpec,
        resolver: SchemaResolver,
        type_converter: TypeConverter,
        type_generator: TypeGenerator,
    ):
        """
        Initialize the method generator.

        Args:
            spec: Parsed OpenAPI specification
            resolver: SchemaResolver for reference resolution
            type_converter: TypeConverter for schema to Luau conversion
            type_generator: TypeGenerator for creating response types
        """
        self.spec = spec
        self.resolver = resolver
        self.type_converter = type_converter
        self.type_generator = type_generator

    def generate_methods(self) -> List[MethodDefinition]:
        """
        Generate all method definitions from the spec.

        Returns:
            List of MethodDefinition objects
        """
        method_defs = []

        for operation in self.spec.operations:
            method_def = self.create_method_definition(operation)
            if method_def:
                method_defs.append(method_def)

        logger.info(f"Generated {len(method_defs)} methods")
        return method_defs

    def create_method_definition(
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

        # Build parameters
        param_info = self._build_parameters(operation)

        # Build parameter list string
        params_list = [f"{p['name']}: {p['type']}" for p in param_info]
        params = ", ".join(params_list) if params_list else ""

        # Determine body parameter
        body_param = next((p["name"] for p in param_info if p["in"] == "body"), "nil")

        # Determine return type
        return_type = self._determine_return_type(operation)

        # Build documentation
        doc_string = self._build_doc_string(operation, param_info, return_type)

        # Check for path variables and query parameters
        has_path_vars = "{" in operation.path and "}" in operation.path
        query_param_names = [p["name"] for p in param_info if p["in"] == "query"]
        has_query_params = len(query_param_names) > 0

        return MethodDefinition(
            name=method_name,
            http_method=operation.method.upper(),
            path=operation.path,
            params=params,
            return_type=return_type,
            body_param=body_param,
            doc_string=doc_string,
            has_path_vars=has_path_vars,
            has_query_params=has_query_params,
            query_params=query_param_names if has_query_params else None,
            tags=operation.tags,
        )

    def _build_parameters(self, operation: Operation) -> List[Dict[str, Any]]:
        """
        Build parameter information from an operation.

        Args:
            operation: Operation object

        Returns:
            List of parameter dictionaries with name, type, in, required, description
        """
        param_info = []

        # Collect parameters from operation
        for param in operation.parameters:
            param_name = getattr(param, "name", "param")
            param_in = getattr(
                param, "param_in", getattr(param, "in_", "query")
            )  # Try param_in or in_
            param_required = getattr(param, "required", False)
            raw_param_type = self.type_converter.convert_parameter_type(param)

            # Prefix custom types with Types.
            param_type = self._prefix_types_with_namespace(raw_param_type)

            # Make optional parameters nullable
            if not param_required and not param_type.endswith("?"):
                param_type += "?"
                raw_param_type += "?"

            param_info.append(
                {
                    "name": param_name,
                    "type": param_type,
                    "raw_type": raw_param_type,
                    "in": param_in,
                    "required": param_required,
                    "description": getattr(param, "description", None)
                    or "No description provided",
                }
            )

        # Add request body parameter
        if operation.request_body:
            request_schema = operation.request_body.get("schema")
            if request_schema:
                # Get the type for the request body
                raw_body_type = self.type_converter.convert_schema(request_schema)
                # Prefix custom types with Types.
                body_type = self._prefix_types_with_namespace(raw_body_type)
                param_info.append(
                    {
                        "name": "params",
                        "type": body_type,
                        "raw_type": raw_body_type,
                        "in": "body",
                        "required": True,
                        "description": "Request body parameters",
                    }
                )

        # Sort parameters: required first, then optional
        param_info.sort(key=lambda p: (not p["required"], p["name"]))

        return param_info

    def _determine_return_type(self, operation: Operation) -> str:
        """
        Determine the return type for an operation.

        Args:
            operation: Operation object

        Returns:
            Luau type string for the return value
        """
        response_types = self.type_generator.create_response_types(operation)
        if not response_types:
            return "any"

        success_types = [
            f"Types.{rt.name}"
            for rt in response_types
            if rt.code >= 200 and rt.code < 300
        ]
        error_types = [
            f"Types.{rt.name}"
            for rt in response_types
            if rt.code < 200 or rt.code >= 300
        ]

        return f"Types.Result<{' | '.join(success_types)}, {' | '.join(error_types)}>"

    def _build_doc_string(
        self, operation: Operation, param_info: List[Dict[str, Any]], return_type: str
    ) -> str:
        """
        Build documentation string for a method.

        Args:
            operation: Operation object
            param_info: List of parameter dictionaries
            return_type: Return type string

        Returns:
            Formatted doc string
        """
        raw_return_type = return_type.replace("Types.", "")
        linebreak = "\n    "
        doc_string = f"""
--[=[
    {operation.description or operation.summary or ""}

    Endpoint: {operation.method.upper()} {operation.path}

    @method {operation.operation_id}
    @within OpenRouter
    {linebreak.join([f"@tag {tag}" for tag in operation.tags])}
    {linebreak+linebreak.join([f"@param {p['name']} {p['raw_type']} -- {p['description']}" for p in param_info]) if param_info else ""}
    @return {raw_return_type}
]=]
""".strip()
        return doc_string

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
        import re

        def replace_type_name(match):
            type_name = match.group(0)
            # Don't prefix primitives or already-prefixed types
            if type_name in primitives or type_name.startswith(f"{namespace}."):
                return type_name
            return f"{namespace}.{type_name}"

        # Match type names (alphanumeric starting with uppercase), but do not match inside string literals
        def sub_outside_strings(s):
            # Split on ("), keep the quotes in result: even indexes are outside, odd are inside strings
            parts = re.split(r'(")', s)
            out = []
            inside = False
            for part in parts:
                if part == '"':
                    inside = not inside
                    out.append(part)
                elif inside:
                    out.append(part)
                else:
                    out.append(
                        re.sub(r"\b[A-Z][a-zA-Z0-9_]*\b", replace_type_name, part)
                    )
            return "".join(out)

        result = sub_outside_strings(type_str)
        return result

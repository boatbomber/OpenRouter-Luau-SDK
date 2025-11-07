"""
Type Generator for the OpenRouter Luau SDK Generator.

Generates Luau type definitions from OpenAPI schemas.
"""

import logging
from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional

from generator.errors import CircularDependencyError
from generator.parser import Operation, ParsedSpec
from generator.schema_analyzer import SchemaAnalyzer
from generator.schema_resolver import SchemaResolver
from generator.type_converter import TypeConverter
from generator.utils import topological_sort

logger = logging.getLogger("generator")


@dataclass
class FieldInfo:
    """Represents a field in a table type."""

    name: str
    type: str
    description: Optional[str] = None
    example: Optional[Any] = None
    minimum: Optional[float] = None
    maximum: Optional[float] = None
    default: Optional[Any] = None
    deprecated: bool = False


@dataclass
class TypeDefinition:
    """Represents a Luau type definition."""

    name: str
    type: str
    code: Optional[int] = None
    description: Optional[str] = None
    example: Optional[Any] = None
    fields: Optional[List[FieldInfo]] = None  # For table types

    @property
    def is_table_type(self) -> bool:
        """Check if this is a table type requiring field documentation."""
        return bool(self.fields and self.type.strip().rstrip("?").startswith("{"))

    @property
    def needs_doc_comment(self) -> bool:
        """Check if type needs documentation."""
        return bool(self.description or self.fields)


class TypeGenerator:
    """
    Generates Luau type definitions from OpenAPI schemas.

    Handles type ordering via topological sort, creates response types,
    and generates proper documentation for each type.
    """

    def __init__(
        self,
        spec: ParsedSpec,
        resolver: SchemaResolver,
        analyzer: SchemaAnalyzer,
        type_converter: TypeConverter,
    ):
        """
        Initialize the type generator.

        Args:
            spec: Parsed OpenAPI specification
            resolver: SchemaResolver for reference resolution
            analyzer: SchemaAnalyzer for dependency analysis
            type_converter: TypeConverter for schema to Luau conversion
        """
        self.spec = spec
        self.resolver = resolver
        self.analyzer = analyzer
        self.type_converter = type_converter

    def generate_types(self) -> List[TypeDefinition]:
        """
        Generate all type definitions from the spec.

        Returns:
            List of TypeDefinition objects in proper dependency order
        """
        type_defs = []

        # Get schema dependencies for ordering
        dependencies = self.analyzer.build_dependency_graph(self.spec.schemas)

        # Sort schemas topologically
        try:
            sorted_names = topological_sort(dependencies)
        except CircularDependencyError as e:
            logger.warning(f"Circular dependencies detected: {e}")
            # Fall back to alphabetical order
            sorted_names = sorted(self.spec.schemas.keys())

        # Generate type definitions in order
        for name in sorted_names:
            schema = self.spec.schemas[name]
            type_def = self.create_type_definition(name, schema)
            if type_def:
                type_defs.append(type_def)

        # Generate response types for operations
        for operation in self.spec.operations:
            response_types = self.create_response_types(operation)
            if response_types:
                type_defs.extend(response_types)

        logger.info(f"Generated {len(type_defs)} types")
        return type_defs

    def create_type_definition(
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

        # Get example
        example = getattr(schema, "example", None)

        # Extract field information for table types
        fields = None
        if hasattr(schema, "properties") and schema.properties:
            fields = []
            required_list = getattr(schema, "required", [])
            required = set(required_list) if required_list else set()

            for prop_name, prop_schema in schema.properties.items():
                prop_type = self.type_converter.convert_schema(prop_schema)
                # Add ? for optional properties
                if prop_name not in required and not prop_type.endswith("?"):
                    prop_type += "?"

                field_description = getattr(prop_schema, "description", None)
                field_example = getattr(prop_schema, "example", None)
                field_minimum = getattr(prop_schema, "minimum", None)
                field_maximum = getattr(prop_schema, "maximum", None)
                field_default = getattr(prop_schema, "default", None)
                field_deprecated = getattr(prop_schema, "deprecated", False)

                fields.append(
                    FieldInfo(
                        name=prop_name,
                        type=prop_type,
                        description=field_description,
                        example=field_example,
                        minimum=field_minimum,
                        maximum=field_maximum,
                        default=field_default,
                        deprecated=field_deprecated,
                    )
                )

        return TypeDefinition(
            name=name,
            type=luau_type,
            description=description,
            example=example,
            fields=fields,
        )

    def create_response_types(
        self, operation: Operation
    ) -> Optional[List[TypeDefinition]]:
        """
        Create response type definitions for an operation.

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

            # Get example from response schema
            example = getattr(response_schema, "example", None)

            response_types.append(
                TypeDefinition(
                    name=type_name,
                    type=luau_type,
                    code=status_code,
                    description=description,
                    example=example,
                )
            )

        return response_types

"""
Type Converter for the OpenRouter Luau SDK Generator.

Converts OpenAPI type schemas to Luau type syntax.
"""

import logging
from typing import Any, Dict, List, Optional, Set

from openapi_pydantic.v3.v3_1_0 import Schema

from generator.constants import LUAU_RESERVED_KEYWORDS
from generator.schema_resolver import SchemaResolver

logger = logging.getLogger("generator")


class TypeConverter:
    """
    Converts OpenAPI schemas to Luau type definitions.

    Handles primitives, arrays, objects, unions, intersections, and references.
    """

    def __init__(self, resolver: SchemaResolver):
        """
        Initialize the type converter.

        Args:
            resolver: SchemaResolver instance for resolving references
        """
        self.resolver = resolver
        self._processing: Set[str] = (
            set()
        )  # Track schemas being processed (for recursion)
        self.conversion_warnings: List[str] = []  # Track conversion issues

    def convert_schema(
        self, schema: Any, name: Optional[str] = None, nullable: bool = False
    ) -> str:
        """
        Convert an OpenAPI schema to a Luau type.

        Args:
            schema: OpenAPI schema object
            name: Optional name for error messages
            nullable: Whether this type should be nullable

        Returns:
            Luau type string
        """
        if schema is None:
            warning = f"Schema is None for '{name or 'unknown'}', defaulting to 'any'"
            logger.warning(warning)
            self.conversion_warnings.append(warning)
            return "any"

        # Handle references
        if hasattr(schema, "ref") and schema.ref:
            schema_name = self.resolver.get_schema_name_from_ref(schema.ref)
            if schema_name:
                type_str = schema_name
                return f"{type_str}?" if nullable else type_str
            # If we can't resolve the ref, try to resolve it
            resolved = self.resolver.resolve_ref(schema.ref)
            if resolved:
                # Convert resolved schema
                return self.convert_schema(resolved, name, nullable)
            warning = f"Could not resolve reference '{schema.ref}' for '{name or 'unknown'}', defaulting to 'any'"
            logger.warning(warning)
            self.conversion_warnings.append(warning)
            return "any"

        # Handle nullable types
        if hasattr(schema, "nullable") and schema.nullable:
            nullable = True

        # Handle unions (anyOf, oneOf)
        if hasattr(schema, "anyOf") and schema.anyOf:
            return self._convert_union(schema.anyOf, nullable)

        if hasattr(schema, "oneOf") and schema.oneOf:
            return self._convert_union(schema.oneOf, nullable)

        # Handle intersections (allOf)
        if hasattr(schema, "allOf") and schema.allOf:
            return self._convert_intersection(schema.allOf, nullable)

        # Handle enums
        if hasattr(schema, "enum") and schema.enum:
            return self._convert_enum(schema.enum, nullable)

        # Handle types
        schema_type = getattr(schema, "type", None)

        if schema_type == "string":
            return self._convert_string(schema, nullable)
        elif schema_type == "number" or schema_type == "integer":
            return "number?" if nullable else "number"
        elif schema_type == "boolean":
            return "boolean?" if nullable else "boolean"
        elif schema_type == "null":
            return "nil"
        elif schema_type == "array":
            return self._convert_array(schema, nullable)
        elif schema_type == "object":
            return self._convert_object(schema, nullable)
        elif isinstance(schema_type, list):
            # Multiple types - treat as union
            types = []
            for t in schema_type:
                if t == "null":
                    nullable = True
                else:
                    # Create a temporary schema for this type
                    temp_schema = Schema(type=t)
                    types.append(self.convert_schema(temp_schema))
            if not types:
                return "nil"
            result = " | ".join(types)
            return (
                f"({result})?"
                if nullable and len(types) > 1
                else result if not nullable else f"{result}?"
            )

        # No type specified - could be any or an object with no type
        if hasattr(schema, "properties") and schema.properties:
            return self._convert_object(schema, nullable)

        # Check if this is an intentionally empty schema (just metadata like nullable)
        # This is a valid OpenAPI pattern meaning "any type"
        has_type_info = (
            (hasattr(schema, "type") and schema.type)
            or (hasattr(schema, "ref") and schema.ref)
            or (hasattr(schema, "properties") and schema.properties)
            or (hasattr(schema, "allOf") and schema.allOf)
            or (hasattr(schema, "anyOf") and schema.anyOf)
            or (hasattr(schema, "oneOf") and schema.oneOf)
            or (hasattr(schema, "items") and schema.items)
            or (hasattr(schema, "enum") and schema.enum)
        )

        if not has_type_info:
            # Schema with no type info - valid pattern for "any type"
            # Don't warn, just return any (possibly nullable)
            return "any?" if nullable else "any"

        # Default to any (with warning for unexpected cases)
        warning = f"No type information found for '{name or 'unknown'}', defaulting to 'any'"
        logger.warning(warning)
        self.conversion_warnings.append(warning)
        return "any?" if nullable else "any"

    def _convert_string(self, schema: Schema, nullable: bool) -> str:
        """Convert a string schema to Luau type."""
        # Check for format-specific types if needed
        # For now, all strings are just 'string'
        return "string?" if nullable else "string"

    def _convert_array(self, schema: Schema, nullable: bool) -> str:
        """Convert an array schema to Luau type."""
        if not hasattr(schema, "items") or schema.items is None:
            # Array without item type - use any
            return "{any}?" if nullable else "{any}"

        item_type = self.convert_schema(schema.items)

        # Wrap in braces for Luau array syntax
        array_type = f"{{{item_type}}}"
        return f"{array_type}?" if nullable else array_type

    def _convert_object(self, schema: Schema, nullable: bool) -> str:
        """Convert an object schema to Luau type."""
        # Check for additionalProperties (dictionary/map type)
        if hasattr(schema, "additionalProperties"):
            if schema.additionalProperties is True:
                # Open dictionary
                dict_type = "{ [string]: any }"
                return f"{dict_type}?" if nullable else dict_type
            elif (
                schema.additionalProperties is not False
                and schema.additionalProperties is not None
            ):
                # Typed dictionary
                value_type = self.convert_schema(schema.additionalProperties)
                dict_type = f"{{ [string]: {value_type} }}"
                return f"{dict_type}?" if nullable else dict_type

        # Regular object with properties
        if not hasattr(schema, "properties") or not schema.properties:
            # Empty object
            obj_type = "{}"
            return f"{obj_type}?" if nullable else obj_type

        # Get required fields
        required_list = getattr(schema, "required", [])
        required = set(required_list) if required_list else set()

        # Build property list
        props = []
        for prop_name, prop_schema in schema.properties.items():
            is_required = prop_name in required
            prop_type = self.convert_schema(prop_schema)

            # Add ? for optional properties
            if not is_required and not prop_type.endswith("?"):
                prop_type += "?"

            # Use bracket notation for reserved keywords
            if prop_name in LUAU_RESERVED_KEYWORDS:
                props.append(f'["{prop_name}"]: {prop_type}')
            else:
                props.append(f"{prop_name}: {prop_type}")

        if not props:
            obj_type = "{}"
        else:
            props_str = ", ".join(props)
            obj_type = f"{{ {props_str} }}"

        return f"{obj_type}?" if nullable else obj_type

    def _convert_union(self, schemas: List[Any], nullable: bool) -> str:
        """Convert anyOf/oneOf to Luau union type."""
        if not schemas:
            warning = "Empty union schema (anyOf/oneOf), defaulting to 'any'"
            logger.warning(warning)
            self.conversion_warnings.append(warning)
            return "any?" if nullable else "any"

        types = []
        for sub_schema in schemas:
            # Check if this schema only contains metadata properties (no actual type info)
            # Common pattern in OpenAPI: anyOf with [type schemas..., {nullable: true}]
            has_type_info = (
                (hasattr(sub_schema, "type") and sub_schema.type)
                or (hasattr(sub_schema, "ref") and sub_schema.ref)
                or (hasattr(sub_schema, "properties") and sub_schema.properties)
                or (hasattr(sub_schema, "allOf") and sub_schema.allOf)
                or (hasattr(sub_schema, "anyOf") and sub_schema.anyOf)
                or (hasattr(sub_schema, "oneOf") and sub_schema.oneOf)
                or (hasattr(sub_schema, "items") and sub_schema.items)
                or (hasattr(sub_schema, "enum") and sub_schema.enum)
                or (hasattr(sub_schema, "additionalProperties") and sub_schema.additionalProperties is not None)
            )

            if not has_type_info:
                # This schema has no type information, only metadata like example, description, nullable, etc.
                # Check if it has nullable flag
                if hasattr(sub_schema, "nullable") and sub_schema.nullable:
                    nullable = True
                # Skip this schema as it's just metadata
                continue

            # Don't propagate nullable to union members
            type_str = self.convert_schema(sub_schema, nullable=False)
            if type_str and type_str not in types:
                types.append(type_str)

        if not types:
            warning = "Union schema (anyOf/oneOf) produced no valid types, defaulting to 'any'"
            logger.warning(warning)
            self.conversion_warnings.append(warning)
            return "any?" if nullable else "any"

        if len(types) == 1:
            result = types[0]
        else:
            result = f"({' | '.join(types)})"

        return f"{result}?" if nullable else result

    def _convert_intersection(self, schemas: List[Any], nullable: bool) -> str:
        """Convert allOf to Luau intersection type."""
        if not schemas:
            warning = "Empty intersection schema (allOf), defaulting to 'any'"
            logger.warning(warning)
            self.conversion_warnings.append(warning)
            return "any?" if nullable else "any"

        types = []
        merged_props: Dict[str, Any] = {}
        merged_required: Set[str] = set()
        has_nullable_part = False

        for sub_schema in schemas:
            # Check if this schema only contains metadata properties (no actual type info)
            # Common pattern in OpenAPI: allOf with [$ref, {example: ...}] or [$ref, {nullable: true}]
            has_type_info = (
                (hasattr(sub_schema, "type") and sub_schema.type)
                or (hasattr(sub_schema, "ref") and sub_schema.ref)
                or (hasattr(sub_schema, "properties") and sub_schema.properties)
                or (hasattr(sub_schema, "allOf") and sub_schema.allOf)
                or (hasattr(sub_schema, "anyOf") and sub_schema.anyOf)
                or (hasattr(sub_schema, "oneOf") and sub_schema.oneOf)
                or (hasattr(sub_schema, "items") and sub_schema.items)
                or (hasattr(sub_schema, "enum") and sub_schema.enum)
                or (hasattr(sub_schema, "additionalProperties") and sub_schema.additionalProperties is not None)
            )

            if not has_type_info:
                # This schema has no type information, only metadata like example, description, etc.
                # Check if it has nullable flag
                if hasattr(sub_schema, "nullable") and sub_schema.nullable:
                    has_nullable_part = True
                # Skip this schema as it's just metadata
                continue

            # Try to merge objects
            if hasattr(sub_schema, "type") and sub_schema.type == "object":
                if hasattr(sub_schema, "properties") and sub_schema.properties:
                    merged_props.update(sub_schema.properties)
                if hasattr(sub_schema, "required") and sub_schema.required:
                    merged_required.update(sub_schema.required)
            elif hasattr(sub_schema, "ref") and sub_schema.ref:
                # Reference - add to intersection
                schema_name = self.resolver.get_schema_name_from_ref(sub_schema.ref)
                if schema_name:
                    types.append(schema_name)
            else:
                # Other type - add to intersection
                type_str = self.convert_schema(sub_schema, nullable=False)
                if type_str:
                    # Check if the type itself is nullable and strip it
                    if type_str.endswith("?"):
                        type_str = type_str[:-1]
                        has_nullable_part = True
                    # Wrap nullable unions in parentheses for intersection
                    if " | nil" in type_str and not type_str.startswith("("):
                        type_str = f"({type_str})"
                    if type_str not in types:
                        types.append(type_str)

        # If we have merged properties, convert them to an object type
        if merged_props:
            obj_schema = Schema(
                type="object",
                properties=merged_props,
                required=list(merged_required) if merged_required else None,
            )
            obj_type = self._convert_object(obj_schema, False)
            types.append(obj_type)

        if not types:
            warning = "Intersection schema (allOf) produced no valid types, defaulting to 'any'"
            logger.warning(warning)
            self.conversion_warnings.append(warning)
            return "any?" if nullable else "any"

        if len(types) == 1:
            result = types[0]
        else:
            result = f"({' & '.join(types)})"

        # Apply nullable if requested or if any part was nullable
        return f"{result}?" if (nullable or has_nullable_part) else result

    def _convert_enum(self, values: List[Any], nullable: bool) -> str:
        """Convert enum values to Luau literal union type."""
        if not values:
            warning = "Empty enum schema, defaulting to 'any'"
            logger.warning(warning)
            self.conversion_warnings.append(warning)
            return "any?" if nullable else "any"

        literals = []
        has_numbers = False

        for value in values:
            if isinstance(value, str):
                # Escape the string value
                escaped = value.replace("\\", "\\\\").replace('"', '\\"')
                literals.append(f'"{escaped}"')
            elif isinstance(value, bool):
                literals.append("true" if value else "false")
            elif isinstance(value, (int, float)):
                # Luau doesn't support number literals in types
                has_numbers = True
            elif value is None:
                nullable = True
            else:
                literals.append(str(value))

        # If enum contains numbers, just use number type
        if has_numbers and not literals:
            return "number?" if nullable else "number"
        elif has_numbers:
            # Mix of numbers and other types - add number to the union
            literals.append("number")

        if not literals:
            return "nil"

        result = " | ".join(literals)
        if len(literals) > 1:
            result = f"({result})"

        return f"{result}?" if nullable else result

    def convert_parameter_type(self, param: Any) -> str:
        """
        Convert a parameter to a Luau type.

        Args:
            param: Parameter object

        Returns:
            Luau type string
        """
        if hasattr(param, "param_schema") and param.param_schema:
            required = getattr(param, "required", False)
            return self.convert_schema(param.param_schema, nullable=not required)

        # Default to any for parameters without schema
        logger.warning(f"No schema found for parameter: {param}")
        return "any"

    def needs_export(self, schema: Any) -> bool:
        """
        Check if a schema should be exported as a named type.

        Args:
            schema: Schema to check

        Returns:
            True if the schema should be exported
        """
        # Export if it's an object with properties or a complex type
        if hasattr(schema, "type"):
            if schema.type == "object":
                return True
            if schema.type == "array" and hasattr(schema, "items"):
                # Export arrays of complex types
                if hasattr(schema.items, "properties"):
                    return True

        # Export unions and intersections
        if (
            hasattr(schema, "anyOf")
            or hasattr(schema, "oneOf")
            or hasattr(schema, "allOf")
        ):
            return True

        # Export enums
        if hasattr(schema, "enum"):
            return True

        return False

    def get_warnings_summary(self) -> str:
        """
        Get a summary of type conversion warnings.

        Returns:
            Summary string with warning count and details
        """
        if not self.conversion_warnings:
            return "No type conversion warnings"

        unique_warnings = list(set(self.conversion_warnings))
        summary = f"Type conversion issues: {len(self.conversion_warnings)} total ({len(unique_warnings)} unique)"
        if len(unique_warnings) <= 10:
            summary += "\n  " + "\n  ".join(unique_warnings)
        else:
            summary += "\n  " + "\n  ".join(unique_warnings[:10])
            summary += f"\n  ... and {len(unique_warnings) - 10} more"

        return summary

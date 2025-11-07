"""
Schema Reference Resolver for the OpenRouter Luau SDK Generator.

Handles resolution of $ref pointers and schema lookups.
"""

import logging
from typing import Any, Dict, Optional

from generator.errors import SchemaResolutionError

logger = logging.getLogger("generator")


class SchemaResolver:
    """
    Resolves schema references and lookups.

    Provides a centralized way to resolve $ref pointers and retrieve schemas
    by name, eliminating tight coupling to the parser.
    """

    def __init__(self, raw_spec: Dict[str, Any], schemas: Dict[str, Any]):
        """
        Initialize the schema resolver.

        Args:
            raw_spec: The raw OpenAPI specification dictionary
            schemas: Dictionary mapping schema names to schema objects
        """
        self.raw_spec = raw_spec
        self.schemas = schemas

    def resolve_ref(self, ref: str) -> Optional[Any]:
        """
        Resolve a $ref pointer to its schema.

        Args:
            ref: Reference string (e.g., '#/components/schemas/Model')

        Returns:
            Referenced schema object or None if not found

        Raises:
            SchemaResolutionError: If the reference is invalid
        """
        if not ref or not ref.startswith("#/"):
            return None

        parts = ref[2:].split("/")  # Remove '#/' and split
        current = self.raw_spec

        for part in parts:
            if isinstance(current, dict) and part in current:
                current = current[part]
            else:
                logger.warning(f"Could not resolve reference: {ref}")
                return None

        return current

    def get_schema_name_from_ref(self, ref: str) -> Optional[str]:
        """
        Extract schema name from a $ref pointer.

        Args:
            ref: Reference string (e.g., '#/components/schemas/Model')

        Returns:
            Schema name (e.g., 'Model') or None if invalid
        """
        if not ref or not ref.startswith("#/components/schemas/"):
            return None

        return ref.split("/")[-1]

    def get_schema(self, name: str) -> Optional[Any]:
        """
        Get a schema by name.

        Args:
            name: Schema name

        Returns:
            Schema object or None if not found
        """
        return self.schemas.get(name)

    def has_schema(self, name: str) -> bool:
        """
        Check if a schema exists.

        Args:
            name: Schema name

        Returns:
            True if the schema exists
        """
        return name in self.schemas

    def get_all_schema_names(self) -> list[str]:
        """
        Get all schema names.

        Returns:
            List of schema names
        """
        return list(self.schemas.keys())

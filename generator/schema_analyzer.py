"""
Schema Analyzer for the OpenRouter Luau SDK Generator.

Analyzes schema dependencies and builds dependency graphs.
"""

import logging
from typing import Any, Dict, List, Set, Optional

from generator.schema_resolver import SchemaResolver

logger = logging.getLogger("generator")


class SchemaAnalyzer:
    """
    Analyzes schemas to find dependencies and build dependency graphs.

    This is the single source of truth for dependency analysis, eliminating
    the duplication between parser and code generator.
    """

    def __init__(self, resolver: SchemaResolver):
        """
        Initialize the schema analyzer.

        Args:
            resolver: SchemaResolver instance for resolving references
        """
        self.resolver = resolver

    def find_dependencies(
        self, schema: Any, visited: Optional[Set[str]] = None
    ) -> Set[str]:
        """
        Find all schema dependencies recursively.

        Args:
            schema: Schema object to analyze
            visited: Set of already visited refs (to prevent infinite recursion)

        Returns:
            Set of schema names that this schema depends on
        """
        if visited is None:
            visited = set()

        dependencies = set()

        # Handle reference schemas
        if hasattr(schema, "ref") and schema.ref:
            schema_name = self.resolver.get_schema_name_from_ref(schema.ref)
            if schema_name and schema_name not in visited:
                dependencies.add(schema_name)
                visited.add(schema_name)

        # Handle properties
        if hasattr(schema, "properties") and schema.properties:
            for prop_schema in schema.properties.values():
                dependencies.update(self.find_dependencies(prop_schema, visited))

        # Handle items (for arrays)
        if hasattr(schema, "items") and schema.items:
            dependencies.update(self.find_dependencies(schema.items, visited))

        # Handle allOf
        if hasattr(schema, "allOf") and schema.allOf:
            for sub_schema in schema.allOf:
                dependencies.update(self.find_dependencies(sub_schema, visited))

        # Handle anyOf
        if hasattr(schema, "anyOf") and schema.anyOf:
            for sub_schema in schema.anyOf:
                dependencies.update(self.find_dependencies(sub_schema, visited))

        # Handle oneOf
        if hasattr(schema, "oneOf") and schema.oneOf:
            for sub_schema in schema.oneOf:
                dependencies.update(self.find_dependencies(sub_schema, visited))

        # Handle additionalProperties
        if hasattr(schema, "additionalProperties") and schema.additionalProperties:
            if not isinstance(schema.additionalProperties, bool):
                dependencies.update(
                    self.find_dependencies(schema.additionalProperties, visited)
                )

        return dependencies

    def build_dependency_graph(self, schemas: Dict[str, Any]) -> Dict[str, List[str]]:
        """
        Build a dependency graph for schemas.

        Args:
            schemas: Dictionary of schemas

        Returns:
            Dictionary mapping schema names to their dependencies
        """
        dependencies: Dict[str, List[str]] = {}

        for name, schema in schemas.items():
            deps = self.find_dependencies(schema)
            # Only include dependencies that exist in the schema set and aren't self-references
            dependencies[name] = [d for d in deps if d in schemas and d != name]

        return dependencies

    def get_schema_dependencies_list(self, schema: Any) -> List[str]:
        """
        Get a list of schema dependencies (convenience method).

        Args:
            schema: Schema object to analyze

        Returns:
            List of schema names (as strings) that this schema depends on
        """
        deps = self.find_dependencies(schema)
        return list(deps)

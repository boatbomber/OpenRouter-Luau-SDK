"""
OpenAPI Parser for the OpenRouter Luau SDK Generator.

Parses OpenAPI specifications and extracts schemas, operations, and other metadata.
"""

import json
import logging
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Dict, List, Optional, Set

import yaml
from openapi_pydantic import OpenAPI
from openapi_pydantic.v3.v3_1_0 import Operation as OpenAPIOperation
from openapi_pydantic.v3.v3_1_0 import Parameter, RequestBody, Response, Schema

logger = logging.getLogger("generator")


@dataclass
class Operation:
    """Represents an API operation (endpoint)."""

    operation_id: str
    method: str  # HTTP method (get, post, etc.)
    path: str
    summary: Optional[str] = None
    description: Optional[str] = None
    request_body: Optional[Any] = None
    responses: Dict[str, Any] = field(default_factory=dict)
    parameters: List[Any] = field(default_factory=list)


@dataclass
class ParsedSpec:
    """Represents a parsed OpenAPI specification."""

    version: str
    title: str
    description: Optional[str]
    schemas: Dict[str, Any]
    operations: List[Operation]
    base_url: Optional[str] = None


class OpenAPIParser:
    """
    Parser for OpenAPI specifications.

    Extracts schemas, operations, and other metadata needed for code generation.
    """

    def __init__(self, spec_path: Path):
        """
        Initialize the parser.

        Args:
            spec_path: Path to the OpenAPI specification file
        """
        self.spec_path = spec_path
        self.raw_spec: Dict[str, Any] = {}
        self.openapi: Optional[OpenAPI] = None

    def parse(self) -> ParsedSpec:
        """
        Parse the OpenAPI specification.

        Returns:
            ParsedSpec containing all extracted information

        Raises:
            ValueError: If the specification is invalid
        """
        logger.info(f"Loading specification from {self.spec_path}")

        # Load the raw spec
        self._load_spec()

        # Parse with pydantic-openapi
        try:
            self.openapi = OpenAPI.model_validate(self.raw_spec)
        except Exception as e:
            raise ValueError(f"Failed to parse OpenAPI spec: {e}")

        # Extract components
        schemas = self._extract_schemas()
        operations = self._extract_operations()

        # Build ParsedSpec
        version = self.raw_spec.get("openapi", "3.0.0")
        info = self.raw_spec.get("info", {})
        title = info.get("title", "OpenRouter API")
        description = info.get("description")

        logger.info(f"Parsed {len(schemas)} schemas and {len(operations)} operations")

        return ParsedSpec(
            version=version,
            title=title,
            description=description,
            schemas=schemas,
            operations=operations,
        )

    def _load_spec(self) -> None:
        """Load the OpenAPI specification from file."""
        content = self.spec_path.read_text(encoding="utf-8")

        if self.spec_path.suffix in [".yaml", ".yml"]:
            self.raw_spec = yaml.safe_load(content)
        elif self.spec_path.suffix == ".json":
            self.raw_spec = json.loads(content)
        else:
            # Try YAML first, then JSON
            try:
                self.raw_spec = yaml.safe_load(content)
            except yaml.YAMLError:
                self.raw_spec = json.loads(content)

    def _extract_schemas(self) -> Dict[str, Any]:
        """
        Extract all schemas from components.schemas.

        Returns:
            Dictionary mapping schema names to schema objects
        """
        schemas = {}

        if not self.openapi or not self.openapi.components:
            return schemas

        if self.openapi.components.schemas:
            for name, schema in self.openapi.components.schemas.items():
                schemas[name] = schema

        return schemas

    def _extract_operations(self) -> List[Operation]:
        """
        Extract all operations from paths.

        Returns:
            List of Operation objects
        """
        operations = []

        if not self.openapi or not self.openapi.paths:
            return operations

        for path, path_item in self.openapi.paths.items():
            if path_item is None:
                continue

            # Extract operations for each HTTP method
            for method in ["get", "post", "put", "delete", "patch", "head", "options"]:
                operation = getattr(path_item, method, None)
                if operation is None:
                    continue

                # Extract operation details
                operation_id = operation.operationId
                if not operation_id:
                    # Generate operation ID from method and path
                    operation_id = self._generate_operation_id(method, path)

                # Extract request body
                request_body = None
                if operation.requestBody:
                    request_body = self._extract_request_body(operation.requestBody)

                # Extract responses
                responses = {}
                if operation.responses:
                    for status_code, response in operation.responses.items():
                        responses[status_code] = self._extract_response(response)

                # Extract parameters
                parameters = []
                if operation.parameters:
                    parameters = list(operation.parameters)

                operations.append(
                    Operation(
                        operation_id=operation_id,
                        method=method,
                        path=path,
                        summary=operation.summary,
                        description=operation.description,
                        request_body=request_body,
                        responses=responses,
                        parameters=parameters,
                    )
                )

        return operations

    def _generate_operation_id(self, method: str, path: str) -> str:
        """
        Generate an operation ID from HTTP method and path.

        Args:
            method: HTTP method
            path: API path

        Returns:
            Generated operation ID in camelCase
        """
        # Remove leading slash and split by '/'
        parts = path.strip("/").split("/")

        # Filter out path parameters (e.g., {id})
        parts = [p for p in parts if not p.startswith("{")]

        # Convert to camelCase
        if not parts:
            return method

        # Combine method with path parts
        parts.insert(0, method)
        return "".join(
            word.capitalize() if i > 0 else word for i, word in enumerate(parts)
        )

    def _extract_request_body(self, request_body: Any) -> Optional[Dict[str, Any]]:
        """
        Extract request body schema.

        Args:
            request_body: RequestBody object

        Returns:
            Extracted request body information
        """
        if not request_body or not request_body.content:
            return None

        # Look for application/json content
        json_content = request_body.content.get("application/json")
        if not json_content:
            return None

        # Try different attribute names for schema
        schema = getattr(json_content, "media_type_schema", None) or getattr(
            json_content, "schema", None
        )
        if not schema:
            return None

        return {
            "schema": schema,
            "required": getattr(request_body, "required", False),
            "description": getattr(request_body, "description", None),
        }

    def _extract_response(self, response: Any) -> Optional[Dict[str, Any]]:
        """
        Extract response schema.

        Args:
            response: Response object

        Returns:
            Extracted response information
        """
        if not response:
            return None

        result = {"description": getattr(response, "description", None), "schema": None}

        if hasattr(response, "content") and response.content:
            # Look for application/json content
            json_content = response.content.get("application/json")
            if json_content:
                # Try different attribute names for schema
                schema = getattr(json_content, "media_type_schema", None) or getattr(
                    json_content, "schema", None
                )
                if schema:
                    result["schema"] = schema

        return result

    def resolve_ref(self, ref: str) -> Optional[Any]:
        """
        Resolve a $ref pointer.

        Args:
            ref: Reference string (e.g., '#/components/schemas/Model')

        Returns:
            Referenced schema or None if not found
        """
        if not ref or not ref.startswith("#/"):
            return None

        parts = ref[2:].split("/")  # Remove '#/' and split
        current = self.raw_spec

        for part in parts:
            if isinstance(current, dict) and part in current:
                current = current[part]
            else:
                return None

        return current

    def get_schema_name_from_ref(self, ref: str) -> Optional[str]:
        """
        Extract schema name from a $ref pointer.

        Args:
            ref: Reference string (e.g., '#/components/schemas/Model')

        Returns:
            Schema name or None
        """
        if not ref or not ref.startswith("#/components/schemas/"):
            return None

        return ref.split("/")[-1]

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
            deps = self._find_schema_dependencies(schema)
            dependencies[name] = [d for d in deps if d in schemas and d != name]

        return dependencies

    def _find_schema_dependencies(
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
            schema_name = self.get_schema_name_from_ref(schema.ref)
            if schema_name and schema_name not in visited:
                dependencies.add(schema_name)
                visited.add(schema_name)

        # Handle properties
        if hasattr(schema, "properties") and schema.properties:
            for prop_schema in schema.properties.values():
                dependencies.update(
                    self._find_schema_dependencies(prop_schema, visited)
                )

        # Handle items (for arrays)
        if hasattr(schema, "items") and schema.items:
            dependencies.update(self._find_schema_dependencies(schema.items, visited))

        # Handle allOf
        if hasattr(schema, "allOf") and schema.allOf:
            for sub_schema in schema.allOf:
                dependencies.update(self._find_schema_dependencies(sub_schema, visited))

        # Handle anyOf
        if hasattr(schema, "anyOf") and schema.anyOf:
            for sub_schema in schema.anyOf:
                dependencies.update(self._find_schema_dependencies(sub_schema, visited))

        # Handle oneOf
        if hasattr(schema, "oneOf") and schema.oneOf:
            for sub_schema in schema.oneOf:
                dependencies.update(self._find_schema_dependencies(sub_schema, visited))

        # Handle additionalProperties
        if hasattr(schema, "additionalProperties") and schema.additionalProperties:
            if not isinstance(schema.additionalProperties, bool):
                dependencies.update(
                    self._find_schema_dependencies(schema.additionalProperties, visited)
                )

        return dependencies

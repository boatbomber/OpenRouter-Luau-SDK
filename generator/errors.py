"""
Custom exception types for the OpenRouter Luau SDK Generator.

Provides a consistent error handling hierarchy for all generator operations.
"""


class GeneratorError(Exception):
    """Base exception for all generator errors."""

    pass


class SchemaValidationError(GeneratorError):
    """Raised when OpenAPI schema validation fails."""

    pass


class SchemaResolutionError(GeneratorError):
    """Raised when a schema reference cannot be resolved."""

    pass


class CircularDependencyError(GeneratorError):
    """Raised when circular dependencies are detected in schema graph."""

    pass


class TemplateRenderError(GeneratorError):
    """Raised when template rendering fails."""

    pass


class FileWriteError(GeneratorError):
    """Raised when file writing operations fail."""

    pass


class FormattingError(GeneratorError):
    """Raised when code formatting fails."""

    pass

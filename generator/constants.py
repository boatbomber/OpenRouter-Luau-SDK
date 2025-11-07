"""
Constants for the OpenRouter Luau SDK Generator.

Centralizes magic strings and constants used throughout the codebase.
"""

# Generator version
GENERATOR_VERSION = "1.0.0"

# Luau primitive types
LUAU_PRIMITIVES = {"string", "number", "boolean", "nil", "any", "never"}

# Default namespace for generated types
DEFAULT_NAMESPACE = "Types"

# Luau reserved keywords that need to be wrapped in brackets
LUAU_RESERVED_KEYWORDS = {
    "and",
    "break",
    "do",
    "else",
    "elseif",
    "end",
    "false",
    "for",
    "function",
    "if",
    "in",
    "local",
    "nil",
    "not",
    "or",
    "repeat",
    "return",
    "then",
    "true",
    "until",
    "while",
    "continue",
    "export",
    "type",
}

# OpenAPI schema reference prefix
OPENAPI_COMPONENTS_PREFIX = "#/components/schemas/"

# Default base URL
DEFAULT_BASE_URL = "https://openrouter.ai/api/v1"

# Template file names
TYPES_TEMPLATE = "types.luau.j2"
METHODS_TEMPLATE = "methods.luau.j2"

# Output file names
TYPES_OUTPUT = "types.luau"
METHODS_OUTPUT = "init.luau"

# Formatting settings
STYLUA_PASSES = 3  # Number of stylua passes to ensure convergence

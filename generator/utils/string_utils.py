"""
String utilities for the OpenRouter Luau SDK Generator.
"""


def sanitize_name(name: str) -> str:
    """
    Sanitize a name to be a valid Luau identifier.

    Args:
        name: Original name

    Returns:
        Sanitized name safe for use as Luau identifier
    """
    # Replace invalid characters with underscores
    sanitized = "".join(c if c.isalnum() or c == "_" else "_" for c in name)

    # Ensure it doesn't start with a number
    if sanitized and sanitized[0].isdigit():
        sanitized = "_" + sanitized

    return sanitized


def escape_string(s: str) -> str:
    """
    Escape a string for use in Luau string literals.

    Args:
        s: String to escape

    Returns:
        Escaped string safe for Luau string literals
    """
    return s.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n")

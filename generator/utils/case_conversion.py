"""
Case conversion utilities for the OpenRouter Luau SDK Generator.
"""


def pascal_case(name: str) -> str:
    """
    Convert a name to PascalCase.

    Args:
        name: Original name (can be snake_case, kebab-case, etc.)

    Returns:
        PascalCase version of the name
    """
    # Split on common separators
    parts = name.replace("-", "_").replace(".", "_").split("_")
    return "".join(word.capitalize() for word in parts if word)


def camel_case(name: str) -> str:
    """
    Convert a name to camelCase.

    Args:
        name: Original name (can be snake_case, kebab-case, etc.)

    Returns:
        camelCase version of the name
    """
    pascal = pascal_case(name)
    if not pascal:
        return pascal
    return pascal[0].lower() + pascal[1:]

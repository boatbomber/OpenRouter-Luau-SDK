"""
Luau code formatting utilities for the OpenRouter Luau SDK Generator.
"""

from datetime import datetime
from typing import Any, List, Optional

from generator.constants import GENERATOR_VERSION


def format_comment(text: str, indent: int = 0, max_width: int = 80) -> str:
    """
    Format text as a Luau block comment with word wrapping.

    Args:
        text: Text to format
        indent: Number of spaces to indent
        max_width: Maximum line width

    Returns:
        Formatted Luau block comment
    """
    if not text:
        return ""

    indent_str = " " * indent
    available_width = max_width - indent - 3  # Account for indent and comment markers

    # Split into lines and wrap
    lines = []
    for paragraph in text.split("\n"):
        if not paragraph.strip():
            lines.append("")
            continue

        words = paragraph.split()
        current_line = []
        current_length = 0

        for word in words:
            word_length = len(word)
            if current_length + word_length + len(current_line) <= available_width:
                current_line.append(word)
                current_length += word_length
            else:
                if current_line:
                    lines.append(" ".join(current_line))
                current_line = [word]
                current_length = word_length

        if current_line:
            lines.append(" ".join(current_line))

    # Format as block comment
    if not lines:
        return ""

    result = [f"{indent_str}--[["]
    for line in lines:
        if line:
            result.append(f"{indent_str}  {line}")
        else:
            result.append(f"{indent_str}")
    result.append(f"{indent_str}]]\n")

    return "\n".join(result)


def format_inline_comment(text: str, indent: int = 0) -> str:
    """
    Format text as a Luau inline comment.

    Args:
        text: Text to format
        indent: Number of spaces to indent

    Returns:
        Formatted Luau inline comment
    """
    indent_str = " " * indent
    return f"{indent_str}-- {text}"


def format_field_example(example: Optional[Any] = None) -> str:
    """
    Format an example value for a field comment.

    Args:
        example: Example value

    Returns:
        Formatted example string, or empty string if None
    """
    if example is None:
        return ""

    if isinstance(example, str):
        escaped = example.replace('"', '\\"')
        return f' (Ex: "{escaped}")'
    elif isinstance(example, (dict, list)):
        import json

        try:
            example_str = json.dumps(example, separators=(",", ":"))
            if len(example_str) > 100:
                example_str = example_str[:97] + "..."
            return f" (Ex: {example_str})"
        except (TypeError, ValueError):
            return f" (Ex: {str(example)})"
    elif isinstance(example, bool):
        return f" (Ex: {'true' if example else 'false'})"
    else:
        return f" (Ex: {str(example)})"


def format_simple_type_doc_comment(
    type_name: str, type: str, description: Optional[str] = None
) -> str:
    """
    Format a doc comment for a simple type.

    Args:
        type_name: Name of the type
        description: Description text

    Returns:
        Formatted doc comment string, or empty string if no description
    """
    if not description:
        return ""
    return f"--[=[\n    @type {type_name} {type}\n    @within OpenRouter\n    {description}\n]=]"


def format_table_type_doc_comment(
    name: str, description: Optional[str] = None, fields: Optional[List[Any]] = None
) -> str:
    """
    Format a doc comment for a table type with field documentation.

    Args:
        name: Name of the interface
        description: Description text for the interface
        fields: List of FieldInfo objects

    Returns:
        Formatted doc comment string
    """
    lines = ["--[=[", f"@interface {name}", "@within OpenRouter"]

    if description:
        lines.append(description)

    if fields:
        lines.append("")  # spacer line
        for field in fields:
            field_comment_parts = []

            # Add deprecation notice first
            if field.deprecated:
                field_comment_parts.append("@deprecated")

            # Add description
            if field.description:
                field_comment_parts.append(field.description)

            # Add range constraint
            if field.minimum is not None or field.maximum is not None:
                if field.minimum is not None and field.maximum is not None:
                    field_comment_parts.append(
                        f"Range: {field.minimum}-{field.maximum}"
                    )
                elif field.minimum is not None:
                    field_comment_parts.append(f"Min: {field.minimum}")
                elif field.maximum is not None:
                    field_comment_parts.append(f"Max: {field.maximum}")

            # Add default value
            if field.default is not None:
                default_str = (
                    f"{field.default!r}"
                    if isinstance(field.default, str)
                    else str(field.default)
                )
                field_comment_parts.append(f"Default: {default_str}")

            # Add example
            if field.example is not None:
                field_comment_parts.append(format_field_example(field.example).strip())

            # Combine all parts
            field_comment = ""
            if field_comment_parts:
                field_comment = " -- " + "; ".join(field_comment_parts)

            lines.append(f"@field {field.name} {field.type}{field_comment}")

    if not lines:
        return ""

    return "\n    ".join(lines) + "\n]=]"


def get_generation_header(source_file: str, external_docs: Optional[Any] = None) -> str:
    """
    Generate a standard header for generated files.

    Args:
        source_file: Path to the source OpenAPI file
        external_docs: Optional ExternalDocs object with url and description

    Returns:
        Formatted header comment
    """
    timestamp = datetime.utcnow().isoformat() + "Z"
    header = f"""--!strict
-- This file is auto-generated from {source_file}
-- DO NOT EDIT MANUALLY - Changes will be overwritten
-- Last generated: {timestamp} (generator v{GENERATOR_VERSION})
"""

    # Add external documentation link if available
    if external_docs and hasattr(external_docs, "url"):
        doc_line = f"-- Documentation: {external_docs.url}"
        if hasattr(external_docs, "description") and external_docs.description:
            doc_line += f" - {external_docs.description}"
        header += doc_line + "\n"

    return header


def indent_text(text: str, spaces: int = 2) -> str:
    """
    Indent all lines in text by the specified number of spaces.

    Args:
        text: Text to indent
        spaces: Number of spaces to indent

    Returns:
        Indented text
    """
    indent_str = " " * spaces
    return "\n".join(
        indent_str + line if line.strip() else line for line in text.split("\n")
    )

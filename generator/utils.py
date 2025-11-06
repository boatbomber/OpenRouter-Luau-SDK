"""
Utility functions for the OpenRouter Luau SDK Generator.
"""

import logging
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, List


def setup_logging(verbose: bool = False) -> logging.Logger:
    """
    Set up logging configuration.

    Args:
        verbose: Enable verbose (DEBUG) logging

    Returns:
        Configured logger instance
    """
    level = logging.DEBUG if verbose else logging.INFO
    logging.basicConfig(level=level, format="%(message)s")
    return logging.getLogger("generator")


def ensure_directory(path: Path) -> None:
    """
    Ensure a directory exists, creating it if necessary.

    Args:
        path: Directory path to create
    """
    path.mkdir(parents=True, exist_ok=True)


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


def escape_string(s: str) -> str:
    """
    Escape a string for use in Luau string literals.

    Args:
        s: String to escape

    Returns:
        Escaped string safe for Luau string literals
    """
    return s.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n")


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


def get_generation_header(source_file: str) -> str:
    """
    Generate a standard header for generated files.

    Args:
        source_file: Path to the source OpenAPI file

    Returns:
        Formatted header comment
    """
    timestamp = datetime.utcnow().isoformat() + "Z"
    return f"""--!strict
-- This file is auto-generated from {source_file}
-- DO NOT EDIT MANUALLY - Changes will be overwritten
-- Last generated: {timestamp}
"""


def topological_sort(items: Dict[str, List[str]]) -> List[str]:
    """
    Perform topological sort on a dependency graph.

    Args:
        items: Dictionary mapping item names to their dependencies

    Returns:
        List of items in topologically sorted order

    Raises:
        ValueError: If circular dependencies are detected
    """
    # Build in-degree map
    in_degree = {item: 0 for item in items}
    for deps in items.values():
        for dep in deps:
            if dep in in_degree:
                in_degree[dep] += 1

    # Start with items that have no dependencies
    queue = [item for item, degree in in_degree.items() if degree == 0]
    result = []

    while queue:
        # Sort for deterministic output
        queue.sort()
        item = queue.pop(0)
        result.append(item)

        # Reduce in-degree for items depending on this one
        for dep_item, deps in items.items():
            if item in deps:
                in_degree[dep_item] -= 1
                if in_degree[dep_item] == 0:
                    queue.append(dep_item)

    # Check for circular dependencies
    if len(result) != len(items):
        remaining = set(items.keys()) - set(result)
        raise ValueError(f"Circular dependencies detected: {remaining}")

    return result


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

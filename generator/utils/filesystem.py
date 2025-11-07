"""
Filesystem utilities for the OpenRouter Luau SDK Generator.
"""

from pathlib import Path


def ensure_directory(path: Path) -> None:
    """
    Ensure a directory exists, creating it if necessary.

    Args:
        path: Directory path to create
    """
    path.mkdir(parents=True, exist_ok=True)

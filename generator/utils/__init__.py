"""
Utility functions for the OpenRouter Luau SDK Generator.

This module re-exports commonly used utilities from focused submodules.
"""

from generator.utils.case_conversion import camel_case, pascal_case
from generator.utils.filesystem import ensure_directory
from generator.utils.graph import topological_sort
from generator.utils.logging import setup_logging
from generator.utils.luau_formatting import (
    format_comment,
    format_field_example,
    format_inline_comment,
    format_simple_type_doc_comment,
    format_table_type_doc_comment,
    get_generation_header,
    indent_text,
)
from generator.utils.string_utils import escape_string, sanitize_name

__all__ = [
    # Logging
    "setup_logging",
    # Filesystem
    "ensure_directory",
    # String utilities
    "sanitize_name",
    "escape_string",
    # Case conversion
    "camel_case",
    "pascal_case",
    # Luau formatting
    "format_comment",
    "format_inline_comment",
    "format_field_example",
    "format_simple_type_doc_comment",
    "format_table_type_doc_comment",
    "get_generation_header",
    "indent_text",
    # Graph algorithms
    "topological_sort",
]

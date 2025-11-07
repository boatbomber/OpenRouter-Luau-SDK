"""
File Writer for the OpenRouter Luau SDK Generator.

Handles template rendering and file writing operations.
"""

import logging
from pathlib import Path
from typing import List, Optional

from jinja2 import Environment, FileSystemLoader, select_autoescape

from generator.constants import DEFAULT_BASE_URL
from generator.errors import FileWriteError, TemplateRenderError
from generator.method_generator import MethodDefinition
from generator.parser import ParsedSpec
from generator.type_generator import TypeDefinition
from generator.utils import (
    ensure_directory,
    format_comment,
    format_simple_type_doc_comment,
    format_table_type_doc_comment,
    get_generation_header,
    indent_text,
)

logger = logging.getLogger("generator")


class FileWriter:
    """
    Writes generated code to files using Jinja2 templates.

    Handles template loading, rendering, and file writing.
    """

    def __init__(self, output_dir: Path, spec: ParsedSpec):
        """
        Initialize the file writer.

        Args:
            output_dir: Output directory for generated files
            spec: Parsed OpenAPI specification (for metadata)
        """
        self.output_dir = output_dir
        self.spec = spec

        # Set up Jinja2 environment
        template_dir = Path(__file__).parent / "templates"
        self.jinja_env = Environment(
            loader=FileSystemLoader(template_dir),
            autoescape=select_autoescape(),
            trim_blocks=True,
            lstrip_blocks=True,
        )

        # Add custom filters
        self.jinja_env.filters["format_comment"] = format_comment
        self.jinja_env.filters["indent"] = indent_text

        # Ensure output directory exists
        ensure_directory(self.output_dir)

    def write_types(self, types: List[TypeDefinition]) -> Path:
        """
        Write type definitions to types.luau file.

        Args:
            types: List of TypeDefinition objects

        Returns:
            Path to the written file

        Raises:
            TemplateRenderError: If template rendering fails
            FileWriteError: If file writing fails
        """
        try:
            # Render template
            template = self.jinja_env.get_template("types.luau.j2")
            content = template.render(
                header=get_generation_header(str(self.spec.title), self.spec.external_docs),
                description=self.spec.description,
                types=types,
                format_comment=format_comment,
                format_simple_type_doc_comment=format_simple_type_doc_comment,
                format_table_type_doc_comment=format_table_type_doc_comment,
            )
        except Exception as e:
            # Try to identify which type caused the error
            type_names = [t.name for t in types] if types else []
            type_count = len(types) if types else 0
            error_msg = f"Failed to render types template ({type_count} types): {e}"
            if type_names:
                error_msg += f"\nType names: {', '.join(type_names[:10])}"
                if len(type_names) > 10:
                    error_msg += f" ... and {len(type_names) - 10} more"
            raise TemplateRenderError(error_msg) from e

        # Write file
        output_path = self.output_dir / "types.luau"
        try:
            output_path.write_text(content, encoding="utf-8")
            logger.debug(f"Wrote types to {output_path}")
        except Exception as e:
            raise FileWriteError(f"Failed to write types file: {e}") from e

        return output_path

    def write_methods(self, methods: List[MethodDefinition]) -> Path:
        """
        Write method definitions to init.luau file.

        Args:
            methods: List of MethodDefinition objects

        Returns:
            Path to the written file

        Raises:
            TemplateRenderError: If template rendering fails
            FileWriteError: If file writing fails
        """
        # Group methods by their first tag for better organization
        methods_by_tag = {}
        tag_descriptions = {tag.name: tag.description for tag in self.spec.tags}

        for method in methods:
            tag = method.tags[0] if method.tags and len(method.tags) > 0 else "General"
            if tag not in methods_by_tag:
                methods_by_tag[tag] = []
            methods_by_tag[tag].append(method)

        try:
            # Render template
            template = self.jinja_env.get_template("methods.luau.j2")
            content = template.render(
                header=get_generation_header(str(self.spec.title), self.spec.external_docs),
                description=f"{self.spec.title} - Generated API Methods",
                methods=methods,
                methods_by_tag=methods_by_tag,
                tag_descriptions=tag_descriptions,
                format_comment=format_comment,
                base_url=self.spec.base_url or DEFAULT_BASE_URL,
            )
        except Exception as e:
            # Try to identify which method caused the error
            method_names = [m.name for m in methods] if methods else []
            method_count = len(methods) if methods else 0
            error_msg = f"Failed to render methods template ({method_count} methods): {e}"
            if method_names:
                error_msg += f"\nMethod names: {', '.join(method_names[:10])}"
                if len(method_names) > 10:
                    error_msg += f" ... and {len(method_names) - 10} more"
            raise TemplateRenderError(error_msg) from e

        # Write file
        output_path = self.output_dir / "init.luau"
        try:
            output_path.write_text(content, encoding="utf-8")
            logger.debug(f"Wrote methods to {output_path}")
        except Exception as e:
            raise FileWriteError(f"Failed to write methods file: {e}") from e

        return output_path

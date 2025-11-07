"""
Code Generator for the OpenRouter Luau SDK Generator.

Orchestrates the generation of Luau type definitions and SDK methods from parsed OpenAPI specifications.
"""

import logging
from pathlib import Path
from typing import Any, List

from generator.constants import STYLUA_PASSES
from generator.file_writer import FileWriter
from generator.formatter import CodeFormatter
from generator.method_generator import MethodGenerator
from generator.parser import OpenAPIParser, ParsedSpec
from generator.schema_analyzer import SchemaAnalyzer
from generator.schema_resolver import SchemaResolver
from generator.type_converter import TypeConverter
from generator.type_generator import TypeGenerator

logger = logging.getLogger("generator")


class CodeGenerator:
    """
    Orchestrates code generation from a parsed OpenAPI specification.

    This class coordinates the various generator components to produce
    complete, formatted Luau SDK code.
    """

    def __init__(self, spec: ParsedSpec, output_dir: Path, parser: OpenAPIParser):
        """
        Initialize the code generator.

        Args:
            spec: Parsed OpenAPI specification
            output_dir: Output directory for generated files
            parser: OpenAPIParser instance (for raw_spec access during transition)
        """
        self.spec = spec
        self.output_dir = output_dir

        # Create resolver and analyzer
        self.resolver = SchemaResolver(parser.raw_spec, spec.schemas)
        self.analyzer = SchemaAnalyzer(self.resolver)

        # Create type converter
        self.type_converter = TypeConverter(self.resolver)

        # Create generators
        self.type_generator = TypeGenerator(
            spec, self.resolver, self.analyzer, self.type_converter
        )
        self.method_generator = MethodGenerator(
            spec, self.resolver, self.type_converter, self.type_generator
        )

        # Create writer and formatter
        self.file_writer = FileWriter(output_dir, spec)
        self.formatter = CodeFormatter()

    def generate(self) -> List[Path]:
        """
        Generate all Luau files.

        Returns:
            List of generated file paths

        Raises:
            Exception: If generation fails
        """
        generated_files = []

        # Generate types
        logger.info("Generating types...")
        types = self.type_generator.generate_types()
        types_file = self.file_writer.write_types(types)
        generated_files.append(types_file)

        # Generate methods
        logger.info("Generating methods...")
        methods = self.method_generator.generate_methods()
        methods_file = self.file_writer.write_methods(methods)
        generated_files.append(methods_file)

        # Format generated files with stylua
        logger.info("Formatting generated files with stylua...")
        # Stylua "misses" some changes on the first pass, which would make CI fail
        # as Stylua would request more changes. Running multiple passes converges on a stable result.
        self.formatter.format_files(generated_files, passes=STYLUA_PASSES)

        # Validate generated files with selene
        self.formatter.validate_with_selene(self.output_dir)

        # Report type conversion warnings
        warnings_summary = self.type_converter.get_warnings_summary()
        if self.type_converter.conversion_warnings:
            logger.info(f"\n{warnings_summary}")
        else:
            logger.debug(warnings_summary)

        return generated_files

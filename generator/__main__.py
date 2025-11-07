#!/usr/bin/env python3
"""
OpenRouter Luau SDK Generator - CLI Entry Point

This module provides the command-line interface for generating a type-safe
Luau SDK from an OpenRouter OpenAPI specification.
"""

import sys
from datetime import datetime
from pathlib import Path

import click

from generator.code_generator import CodeGenerator
from generator.parser import OpenAPIParser
from generator.utils.filesystem import ensure_directory
from generator.utils.logging import setup_logging


@click.command()
@click.option(
    "--input",
    "-i",
    type=click.Path(exists=True, path_type=Path),
    required=True,
    help="Path to the OpenAPI specification file (YAML or JSON)",
)
@click.option(
    "--output",
    "-o",
    type=click.Path(path_type=Path),
    default=Path("src"),
    help="Output directory for generated files (default: src/)",
)
@click.option("--verbose", "-v", is_flag=True, help="Enable verbose logging")
@click.option(
    "--dry-run",
    is_flag=True,
    help="Preview what would be generated without writing files",
)
def main(input: Path, output: Path, verbose: bool, dry_run: bool):
    """
    Generate a type-safe Luau SDK from an OpenRouter OpenAPI specification.

    This tool parses an OpenAPI YAML/JSON file and generates:
    - Type definitions in src/generated/types.luau
    - SDK methods in src/generated/methods.luau

    Example usage:
        python -m generator -i input/openrouter.openapi.yaml -o src/
    """
    # Set up logging
    logger = setup_logging(verbose)

    try:
        logger.info(f"OpenRouter Luau SDK Generator")
        logger.info(f"=" * 60)
        logger.info(f"Input:  {input.absolute()}")
        logger.info(f"Output: {output.absolute()}")

        if dry_run:
            logger.info("DRY RUN MODE - No files will be written")

        logger.info(f"=" * 60)

        # Validate input file
        if not input.exists():
            logger.error(f"Input file not found: {input}")
            sys.exit(1)

        # Parse OpenAPI specification
        logger.info("Parsing OpenAPI specification...")
        parser = OpenAPIParser(input)
        spec = parser.parse()

        logger.info(f"Found {len(spec.schemas)} schemas")
        logger.info(f"Found {len(spec.operations)} operations")

        if verbose:
            logger.info("\nSchemas:")
            for schema_name in spec.schemas.keys():
                logger.info(f"  - {schema_name}")

            logger.info("\nOperations:")
            for op in spec.operations:
                logger.info(f"  - {op.operation_id} ({op.method.upper()} {op.path})")

        # Generate code
        logger.info("\nGenerating Luau code...")
        generator = CodeGenerator(spec, output, parser)

        if dry_run:
            # Preview mode
            logger.info("\nPreview of generated files:")
            logger.info(f"\n  {output / 'generated' / 'types.luau'}")
            logger.info(f"  {output / 'generated' / 'methods.luau'}")
            logger.info("\nRun without --dry-run to write files")
        else:
            # Generate files
            generated_files = generator.generate()

            logger.info("\nGenerated files:")
            for file_path in generated_files:
                logger.info(f"  ✓ {file_path}")

            logger.info("\n" + "=" * 60)
            logger.info("Generation completed successfully!")
            logger.info("=" * 60)

    except Exception as e:
        logger.error(f"\nError: {e}")
        if verbose:
            import traceback

            logger.error(traceback.format_exc())
        sys.exit(1)


if __name__ == "__main__":
    main()

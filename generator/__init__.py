"""
OpenRouter Luau SDK Generator

A Python-based code generator that produces a type-safe Luau SDK from the
OpenRouter OpenAPI specification.
"""

__version__ = "1.0.0"

from generator.code_generator import CodeGenerator
from generator.errors import (
    CircularDependencyError,
    FileWriteError,
    FormattingError,
    GeneratorError,
    SchemaResolutionError,
    SchemaValidationError,
    TemplateRenderError,
)
from generator.file_writer import FileWriter
from generator.formatter import CodeFormatter
from generator.method_generator import MethodDefinition, MethodGenerator
from generator.parser import OpenAPIParser, Operation, ParsedSpec
from generator.schema_analyzer import SchemaAnalyzer
from generator.schema_resolver import SchemaResolver
from generator.type_converter import TypeConverter
from generator.type_generator import FieldInfo, TypeDefinition, TypeGenerator

__all__ = [
    # Core classes
    "OpenAPIParser",
    "ParsedSpec",
    "Operation",
    "CodeGenerator",
    # Schema resolution and analysis
    "SchemaResolver",
    "SchemaAnalyzer",
    # Type conversion and generation
    "TypeConverter",
    "TypeGenerator",
    "TypeDefinition",
    "FieldInfo",
    # Method generation
    "MethodGenerator",
    "MethodDefinition",
    # File operations
    "FileWriter",
    "CodeFormatter",
    # Errors
    "GeneratorError",
    "SchemaValidationError",
    "SchemaResolutionError",
    "CircularDependencyError",
    "TemplateRenderError",
    "FileWriteError",
    "FormattingError",
]

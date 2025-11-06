"""
OpenRouter Luau SDK Generator

A Python-based code generator that produces a type-safe Luau SDK from the
OpenRouter OpenAPI specification.
"""

__version__ = "1.0.0"

from generator.code_generator import CodeGenerator
from generator.parser import OpenAPIParser, Operation, ParsedSpec
from generator.type_converter import TypeConverter

__all__ = [
    "OpenAPIParser",
    "ParsedSpec",
    "Operation",
    "TypeConverter",
    "CodeGenerator",
]

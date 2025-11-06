# OpenRouter Luau SDK Generator

A Python-based code generator that produces a type-safe Luau SDK from the OpenRouter OpenAPI specification.

## Overview

This generator automatically creates:

- Type-safe Luau type definitions from OpenAPI schemas
- SDK method signatures for all OpenRouter API endpoints

## Installation

Install the required dependencies:

```bash
pip install -r requirements.txt
```

## Usage

### Basic Usage

Generate the SDK from an OpenAPI specification:

```bash
python -m generator --input input/openrouter.openapi.yaml --output src/
```

### Command-Line Options

- `--input`, `-i`: Path to the OpenAPI specification file (YAML or JSON)
- `--output`, `-o`: Output directory for generated files (default: `src/`)
- `--verbose`, `-v`: Enable verbose logging
- `--dry-run`: Preview what would be generated without writing files

### Example

```bash
# Generate with verbose output
python -m generator -i input/openrouter.openapi.yaml -o src/ -v

# Dry run to preview changes
python -m generator -i input/openrouter.openapi.yaml -o src/ --dry-run
```

## Generated Files

The generator creates two files:

### `src/types.luau`

Contains all type definitions extracted from the OpenAPI specification:

- Request/response types
- Enum types (as literal unions)
- Nested object types
- Union and intersection types

### `src/init.luau`

Contains SDK method signatures for all API endpoints:

- Method names based on `operationId`
- Typed parameters from request bodies
- Typed return values from responses
- Documentation comments from operation descriptions

## Limitations

- **No streaming support**: Streaming endpoints are not generated (add manually)
- **No runtime validation**: Types are compile-time only
- **No error handling**: No retry logic, just returns the error type

## References

- [OpenRouter API Documentation](https://openrouter.ai/docs)
- [Luau Language Documentation](https://luau-lang.org)
- [OpenAPI Specification](https://spec.openapis.org/oas/v3.1.0)
- [Pydantic OpenAPI](https://github.com/kuimono/openapi-pydantic)
- [Jinja2 Documentation](https://jinja.palletsprojects.com/)

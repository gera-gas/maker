# Maker

[![PyPI version](https://img.shields.io/pypi/v/maker.svg)](https://pypi.org/project/maker/)
[![Python versions](https://img.shields.io/pypi/pyversions/maker.svg)](https://pypi.org/project/maker/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

AI-powered CLI tool for generating projects and build files with natural language.

## Features

- AI-powered generation using LLMs (OpenAI, Local models)
- Template-based generation for deterministic output
- Multi-language support (C, C++, Python, etc.)
- Build system integration (CMake, Makefile, etc.)
- Interactive workflow commands

## Quick Start

```bash
# Install from PyPI
pip install maker

# Or with uv
uv pip install maker

# Check installation
maker --help
```

## Documentation
Full documentation available at [GitHub Repository](https://github.com/gera-gas/maker).

## Development
```bash
# Clone and setup
git clone https://github.com/gera-gas/maker
cd maker

# Install uv if not present
curl -LsSf https://astral.sh/uv/install.sh | sh

# Setup environment
uv venv
# On Windows: .venv\Scripts\activate
# On Linux/macOS: source .venv/bin/activate
uv sync --dev
uv pip install -e .
```

## License
MIT License - see [LICENSE](LICENSE) file.

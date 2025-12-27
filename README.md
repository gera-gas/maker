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

## Design
```bash
# 1. Для инженера данных (наш текущий фокус)
maker data process sales.csv --clean --enrich --validate
maker data extract-entities logs.txt --model deepseek-coder

# 2. Для разработчика (оригинальная идея)
maker project new rust-service --template axum
maker build generate --target wasm --toolchain nightly

# 3. Общие AI-команды
maker ai chat "Объясни этот код" --file main.rs
maker ai translate schema.sql --from postgres --to sqlite
```

## План по расширению проекта
```text
src/maker/
├── __init__.py
├── cli.py                      # Существующая точка входа Click
│
├── core/                       # НОВОЕ: Ядро системы (будущие Rust-компоненты)
│   ├── __init__.py
│   └── cache.py               # Будущая замена на Rust
│
├── processing/                 # НОВОЕ: Модуль обработки данных из нашего чата!
│   ├── __init__.py
│   ├── pipeline.py            # DataPreparationPipeline - главный класс
│   ├── loaders.py             # DataLoader
│   ├── normalizers.py         # TextNormalizer
│   ├── parsers.py             # StructuredDataParser (JSON, списки)
│   ├── mappers.py             # CategoryMapper
│   ├── extractors.py          # FeatureExtractor
│   ├── validators.py          # QualityController
│   └── enrichers.py           # LLMEnricher - для обогащения через ИИ
│
├── ai/                         # НОВОЕ: Клиенты и оркестрация ИИ-моделей
│   ├── __init__.py
│   ├── client.py              # Универсальный клиент (OpenAI, локальный Ollama)
│   └── prompts.py             # Управление промптами
│
├── templates/                  # Существующая папка для Jinja2
│   └── ...                    # Ваши шаблоны
│
└── utils/                      # НОВОЕ: Общие утилиты
    ├── __init__.py
    └── config.py              # Загрузка YAML-конфигов
```

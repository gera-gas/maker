# Maker
AI-powered CLI tool for generating projects and build files with natural language.

## Installation

```bash
pip install maker
```

# Coming soon...
```bash
maker --help
```

# Development
В `powershell` может не запуститься VENV из-за установленной политики, поменять командой:
```powershell
Get-ExecutionPolicy -List
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```
Установка зависимостей
```bash
uv pip install -e ".[dev]"
```

# Project structure

```text
maker/
├── pyproject.toml          # Основной конфиг (PEP 621)
├── uv.lock                 # Lock файл (генерируется uv)
├── README.md
├── LICENSE
├── .gitignore
├── .python-version        # 3.9+
│
├── src/                   # Исходный код (PEP 420)
│   └── maker/
│       ├── __init__.py
│       ├── __main__.py
│       ├── cli.py
│       ├── commands/
│       │   ├── __init__.py
│       │   ├── template.py
│       │   ├── ai.py
│       │   ├── config.py
│       │   └── analyze.py
│       ├── core/
│       │   ├── __init__.py
│       │   ├── template_engine.py
│       │   ├── ai_provider.py
│       │   └── context_manager.py
│       ├── providers/
│       │   ├── __init__.py
│       │   ├── base.py
│       │   ├── local_llama.py
│       │   └── openai.py
│       └── utils/
│           ├── __init__.py
│           └── file_utils.py
│
├── templates/             # Стандартные шаблоны
│   ├── cpp/
│   ├── c/
│   └── rust/
│
├── tests/
│   ├── __init__.py
│   ├── conftest.py
│   ├── test_cli.py
│   └── test_template.py
│
├── docs/
│   ├── index.md
│   └── getting-started.md
│
├── scripts/
│   ├── install-dev.sh
│   └── release.py
│
├── .pre-commit-config.yaml
└── .editorconfig
```

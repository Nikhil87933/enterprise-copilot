.PHONY: check test fix lint format lock-check

# Run all non-modifying quality checks.
check: lock-check lint
	uv run ruff format --check .
	uv run pytest

# Run the automated test suite.
test:
	uv run pytest

# Automatically fix lint issues and format code.
fix:
	uv run ruff check --fix .
	uv run ruff format .

# Check code quality without modifying files.
lint:
	uv run ruff check .

# Format Python files.
format:
	uv run ruff format .

# Verify that the lockfile is consistent with project dependencies.
lock-check:
	uv lock --check

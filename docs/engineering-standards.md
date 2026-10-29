# Engineering Standards

## 1. Python Project and Dependency Management

- Use Python 3.14 or later, subject to dependency compatibility.
- Use `uv` for dependency management, virtual environments, and lockfile maintenance.
- Declare project dependencies in `pyproject.toml`.
- Commit `uv.lock` to version control to support reproducible installations.
- Do not install project dependencies globally.
- Add dependencies only when justified by implementation requirements.

## 2. Formatting, Linting, and Type Checking

- Use Ruff for Python linting and formatting.
- Configure Ruff in `pyproject.toml`.
- Run `make check` before committing changes.
- Run `make fix` to apply supported lint fixes and formatting.
- Use Python type hints for function parameters, return values, and important data structures.
- Evaluate and select a dedicated type checker when the application implementation begins.

## 3. Unit and Integration Testing

- Write unit tests for business logic and important functions.
- Use integration tests to validate interactions between application components and external systems.
- Keep unit tests independent of external services wherever practical.
- Use test data and mock dependencies when appropriate.
- Run automated tests locally and in CI.
- Use pytest for automated tests. Establish test coverage expectations when application functionality is implemented.

## 4. Configuration and Secrets Management

- Keep environment-specific configuration outside application logic.
- Use environment variables for configuration that varies between environments.
- Provide `.env.example` to document required configuration variables without real credentials.
- Never commit passwords, API keys, access tokens, private keys, or production secrets.
- Keep local environment files out of version control.
- Validate required configuration during application startup.
- Use an appropriate secrets manager if deployment requirements justify one.

## 5. Logging and Error Handling

- Use Python's standard `logging` module unless requirements justify another solution.
- Include useful context in log messages while avoiding sensitive information.
- Handle expected failures explicitly.
- Avoid silently swallowing exceptions.
- Raise meaningful exceptions and preserve diagnostic context.
- Return consistent, appropriate errors at application boundaries.
- Do not expose credentials, tokens, or confidential business data in logs or error responses.

## 6. Naming Conventions and Code Organization

- Follow PEP 8 naming conventions.
- Use `snake_case` for modules, functions, variables, and Python packages.
- Use `PascalCase` for classes.
- Use `UPPER_SNAKE_CASE` for constants.
- Prefer descriptive names and small, focused functions.
- Keep business logic separate from infrastructure and external-system integrations where appropriate.
- Introduce abstractions when they solve a demonstrated problem; avoid speculative frameworks and unnecessary layers.
- Keep modules cohesive and dependencies explicit.

## 7. Git and Pull Request Workflow

- Keep `main` as the stable integration branch.
- Create short-lived feature branches for changes.
- Use Conventional Commit-style messages, such as `feat:`, `fix:`, `test:`, `docs:`, and `chore:`.
- Submit pull requests for changes entering `main`.
- Require CI checks and the configured review approvals before merging.
- Use squash merging where configured.
- Do not force-push to protected branches.

## 8. Continuous Integration

- Use GitHub Actions for automated quality checks.
- Run dependency-lock validation, linting, and formatting checks in CI.
- Run the automated test suite through make check in CI.
- Keep CI failures visible and resolve them before merging.
- Ensure the CI workflow and required status checks remain aligned.

## 9. General Engineering Principles

- Prefer simple, maintainable solutions over unnecessary complexity.
- Implement only confirmed requirements.
- Keep dependencies and infrastructure proportional to actual needs.
- Validate changes incrementally.
- Document important architectural and engineering decisions.
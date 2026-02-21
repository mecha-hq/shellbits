# Agent Guidelines for Shellbits Repository

This document provides guidelines for agentic coding tools operating in the shellbits repository.

## Build/Lint/Test Commands

### Shell Scripts

**Linting:**
```bash
# Lint all shell scripts
make shell-lint

# Lint with Docker
make shell-lint-docker
```

**Formatting:**
```bash
# Format all shell scripts
make shell-format

# Format with Docker
make shell-format-docker
```

### Go Code

**Linting:**
```bash
# Lint Go code
make lint
```

**Formatting:**
```bash
# Format Go code
make format
```

**Testing:**
```bash
# Run all tests
make test

# Run unit tests only
make test-unit

# Run integration tests
make test-integration

# Run end-to-end tests
make test-e2e

# Run single test (using ginkgo)
ginkgo run -vv --focus="TestName" ./path/to/test
```

**Coverage:**
```bash
# Show coverage
make show-coverage
```

### File Linting

```bash
# Lint files
make file-lint

# Lint files with Docker
make file-lint-docker
```

### Makefile Linting

```bash
# Lint Makefiles
make mkfile-lint
```

## Code Style Guidelines

### Shell Scripts

1. **Shebang**: Use `#!/bin/sh` for POSIX compliance
2. **Error Handling**: Always include `set -e` and `set -o errexit -o nounset` at the beginning
3. **Indentation**: Use tabs for indentation (2 spaces equivalent)
4. **Quoting**: Always quote variables: `"$variable"`
5. **Error Messages**: Redirect error messages to stderr: `echo "Error message" >&2`
6. **Exit Codes**: Use explicit exit codes: `exit 1` for errors

### Go Code

1. **Imports**: 
   - Use `goimports` for automatic import management
   - Group imports: standard library, third-party, local packages
   - Local prefix: `github.com/mecha-hq`

2. **Formatting**:
   - Use `gofmt` for basic formatting
   - Use `gofumpt` for additional formatting rules
   - Use `gci` for import organization

3. **Naming Conventions**:
   - Use camelCase for variables and functions
   - Use PascalCase for exported types and functions
   - Use ALL_CAPS for constants
   - Keep names concise but descriptive

4. **Error Handling**:
   - Always check errors
   - Use descriptive error messages
   - Wrap errors with context: `fmt.Errorf("failed to do X: %w", err)`

5. **Testing**:
   - Use `ginkgo` for BDD-style tests
   - Test files should end with `_test.go`
   - Use `-race` flag for race condition detection
   - Aim for high code coverage

### Makefiles

1. **Indentation**: Use tabs only (never spaces)
2. **PHONY Targets**: Declare all non-file targets as `.PHONY`
3. **Variables**: Use `?=` for overrideable variables
4. **Include Order**: Include utility files first, then domain-specific files
5. **Error Handling**: Use `@` prefix to suppress command echo for clean output

### General Rules

1. **ShellCheck Configuration**: Follow `.rules/shellcheck.yaml`
2. **Checkmake Configuration**: Follow `.rules/checkmake.yaml`
3. **POSIX Compliance**: Ensure shell scripts are POSIX compliant
4. **Docker Images**: Use specified container images for linting/formatting
5. **Environment Variables**: Use module-specific prefixes (e.g., `GOLANG_`, `SHELL_`)

## Tool Configuration

### ShellCheck
- Disabled rules: SC2034, SC2155, SC2086
- Severity: error
- POSIX compliance: enabled

### Checkmake
- Strict mode: enabled
- Custom rules for duplicate PHONY targets and consistent indentation

### GolangCI-Lint
- Configuration file: `.rules/.golangci.yml` (if present)
- Run with: `golangci-lint run --color=always`

## Best Practices

1. **Idempotency**: Scripts should be idempotent where possible
2. **Error Handling**: Always handle errors explicitly
3. **Logging**: Provide meaningful output for debugging
4. **Documentation**: Comment complex logic and non-obvious decisions
5. **Testing**: Test both success and failure cases
6. **Performance**: Optimize for readability first, performance second

## Common Patterns

### Shell Script Template
```bash
#!/bin/sh

set -e
set -o errexit -o nounset

# Your code here
echo "Script executed successfully"
```

### Makefile Target Template
```makefile
.PHONY: target-name
target-name:
	@echo "Running target-name"
	@command-to-run
```

### Go Test Template
```go
var _ = Describe("PackageName", func() {
    Context("When testing X", func() {
        It("should do Y", func() {
            // Test implementation
            Expect(result).To(Equal(expected))
        })
    })
})
```

## Running Specific Tests

To run a single test or specific tests:

```bash
# Using ginkgo to run specific test
ginkgo run -vv --focus="TestSpecificFunction" ./path/to/package

# Using go test for unit tests
go test -v -run "TestSpecificFunction" ./path/to/package
```

## CI/CD Integration

The repository is designed to work with:
- Mise for tool management
- Asdf for plugin management
- Docker for isolated environments
- GitHub Actions for CI/CD pipelines

## Environment Variables

Use the following patterns for environment variables:
- `MODULE_FORCE`: Force flag for module operations
- `MODULE_SHELLBITS_DIR`: Directory where shellbits is installed
- `MODULE_IMAGE`: Docker image to use for operations

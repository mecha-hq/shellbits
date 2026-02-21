# File kit environment variables
# This file contains configuration for the file kit

# File patterns
FILE_PATTERNS="*.sh,*.md,*.txt,*.yaml,*.json"
FILE_EXCLUDE_PATTERNS=".git/*,node_modules/*,vendor/*"

# Formatting configuration
FILE_FORMAT_WRITE="false"
FILE_FORMAT_TOOLS="prettier,shfmt"

# Linting configuration
FILE_LINT_STRICT="false"
FILE_LINT_TOOLS="shellcheck,markdownlint"

# Export all variables
for var in $(compgen -v | grep "^FILE_"); do
    export "$var"
done
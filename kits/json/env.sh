# JSON kit environment variables
# This file contains configuration for the json kit

# JSON file patterns
JSON_FILE_PATTERNS="*.json"
JSON_EXCLUDE_PATTERNS=".git/*,node_modules/*,vendor/*"

# Formatting configuration
JSON_FORMAT_WRITE="false"
JSON_FORMAT_INDENT="2"

# Validation configuration
JSON_VALIDATE_STRICT="false"
JSON_VALIDATE_SCHEMA=""

# jq configuration
JSON_JQ_VERSION="latest"
JSON_JQ_COLOR="auto"

# Export all variables
for var in $(compgen -v | grep "^JSON_"); do
    export "$var"
done
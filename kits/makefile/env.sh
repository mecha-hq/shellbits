# Makefile kit environment variables
# This file contains configuration for the makefile kit

# Makefile patterns
MAKEFILE_PATTERNS="Makefile,GNUmakefile,makefile"
MAKEFILE_EXCLUDE_PATTERNS=".git/*,node_modules/*,vendor/*"

# Checkmake configuration
MAKEFILE_CHECKMAKE_CONFIG=".checkmake.yml"
MAKEFILE_CHECKMAKE_STRICT="false"
MAKEFILE_CHECKMAKE_VERBOSE="false"

# Export all variables
for var in $(compgen -v | grep "^MAKEFILE_"); do
    export "$var"
done
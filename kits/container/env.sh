# Container kit environment variables
# This file contains configuration for the container kit

# Docker configuration
CONTAINER_DOCKER_IMAGE=""
CONTAINER_DOCKER_FILE="Dockerfile"
CONTAINER_DOCKER_CONTEXT="."
CONTAINER_DOCKER_BUILD_ARGS=""

# Hadolint configuration
CONTAINER_HADOLINT_CONFIG=""
CONTAINER_HADOLINT_IGNORE=""

# Cosign configuration
CONTAINER_SIGN="false"
CONTAINER_COSIGN_KEY=""
CONTAINER_COSIGN_PASSWORD=""

# General container configuration
CONTAINER_REGISTRY=""
CONTAINER_REPOSITORY=""
CONTAINER_TAG="latest"

# Export all variables
for var in $(compgen -v | grep "^CONTAINER_"); do
    export "$var"
done
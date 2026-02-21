# Kubernetes kit environment variables
# This file contains configuration for the kubernetes kit

# Kubernetes manifest configuration
KUBERNETES_MANIFEST_DIRS="./manifests,./kubernetes,./k8s"
KUBERNETES_MANIFEST_EXTENSIONS=".yaml,.yml,.json"
KUBERNETES_VALIDATE_STRICT="false"

# Helm chart configuration
KUBERNETES_HELM_CHART_DIRS="./charts,./helm"
KUBERNETES_HELM_VALUES_FILES="values.yaml"
KUBERNETES_HELM_LINT_STRICT="false"

# Kubernetes tools configuration
KUBERNETES_KUBECTL_VERSION="latest"
KUBERNETES_HELM_VERSION="latest"
KUBERNETES_KUSTOMIZE_VERSION="latest"

# Validation configuration
KUBERNETES_VALIDATE_SCHEMA="true"
KUBERNETES_VALIDATE_DEPRECATIONS="true"
KUBERNETES_VALIDATE_UNKNOWN_FIELDS="false"

# Export all variables
for var in $(compgen -v | grep "^KUBERNETES_"); do
    export "$var"
done
# THIS FILE IS AUTOGENERATED BY SHELLBITS. YOU SHOULD NOT COMMIT IT.

# Set default trigger mode to manual
trigger_mode(TRIGGER_MODE_MANUAL)

# Disable analytics
analytics_settings(False)

# Disable secrets scrubbing
secret_settings(disable_scrub=True)

# Allow only kind-flare k8s context
allow_k8s_contexts("${TILT_FILES_SETUP_ALLOW_K8S_CONTEXTS}")

# Install Tilt extensions
load("ext://namespace", "namespace_create")
load("ext://namespace", "namespace_inject")

# Create k8s namespaces
namespace_create("${TILT_FILES_SETUP_NAMESPACE}")

# Adjust tilt settings
update_settings(k8s_upsert_timeout_secs = 300)

# Create tls secrets
tls_manifest = read_file("${TILT_FILES_SETUP_TLS_MANIFEST_PATH}")
k8s_yaml(namespace_inject(tls_manifest, "${TILT_FILES_SETUP_NAMESPACE}"))

${TILT_FILES_SETUP_EXTRA_CONFIGS}
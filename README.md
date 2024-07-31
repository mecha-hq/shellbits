# Mecha Shellbits

Atomic, self-contained, composable shell scripts and Makefiles to use for development and CI pipelines.

Shellbits is a library that can be used as is or as a reference for your own scripts.

Ideally it will grow in a framework with its own rules and conventions.

## Installation

Clone this repository and reference the scripts from there, or copy them to your own project within the scripts folder.

## Usage

This project goes hand in hand with makefiles, so you can use the scripts as makefile targets, or include the makefile provided here within your own project makefile.

## Environment Variables

It is possible to set values to the scripts via environment variables: they start with the name of the make target they are in and you can set them up in your project folder using a tool such as `direnv` or `mise`.

You can pass in any of the variable described here when invoking the makefile targets, eg: `make tilt-up FORCE=1`.

Keep in mind that more specific environment variables will win over less specific ones, eg: setting `TILT_DOWN_FORCE` will shadow `TILT_FORCE` and `FORCE`.

### asdf

Environment variables:

- `ASDF_SHELLBITS_DIR`: the directory where shellbits is installed.

### brew

Environment variables:

- `BREW_SHELLBITS_DIR`: the directory where shellbits is installed.

### cosign

Environment variables:

- `COSIGN_SHELLBITS_DIR`: the directory where shellbits is installed.

### docker

Environment variables:

- `DOCKER_SHELLBITS_DIR`: the directory where shellbits is installed.
- `DOCKER_HADOLINT_IMAGE`: the hadolint image to use. Defaults to `hadolint/hadolint:v2.12.0-alpine`.

### file

Environment variables:

- `FILE_SHELLBITS_DIR`: the directory where shellbits is installed.
- `FILE_FILELINT_IMAGE`: the file-lint image to use. Defaults to `cytopia/file-lint:latest-0.8`.

### golang

Environment variables:

- `GOLANG_SHELLBITS_DIR`: the directory where shellbits is installed.

### goreleaser

Environment variables:

- `GORELEASER_SHELLBITS_DIR`: the directory where shellbits is installed.

### helm

Environment variables:

- `HELM_SHELLBITS_DIR`: the directory where shellbits is installed.
- `HELM_CHART_TESTING_IMAGE`: the chart-testing image to use. Defaults to `quay.io/helmpack/chart-testing:v3.7.0`.

#### install

Environment variables:

- `HELM_INSTALL_CHART_PATH`: path to the helm chart to install. Defaults to `.`.
- `HELM_INSTALL_RELEASE_NAME`: name of the helm release. Defaults to the name of the folder from where the script is called.
- `HELM_INSTALL_KUBE_CONFIG`: path to the kubeconfig file. Defaults to `~/.kube/config`.
- `HELM_INSTALL_KUBE_NAMESPACE`: namespace where to install the helm chart. Defaults to `default`.

#### lint

Environment variables:

- `HELM_LINT_CHARTS_PATH`: path of the charts to lint. Defaults to `.`.
- `HELM_LINT_CONFIG_PATH`: path of the helm lint configuration file. Defaults to `.rules/ct.yaml`.
- `HELM_LINT_VALIDATE_MAINTAINERS`: whether to validate the maintainers file. Defaults to `false`.

#### template

Environment variables:

- `HELM_TEMPLATE_CHART_NAME`: name of the helm chart release. Defaults to the name of the folder from where the script is called.
- `HELM_TEMPLATE_CHART_PATH`: path to the helm chart. Defaults to `.`.
- `HELM_TEMPLATE_CHART_COLOR`: whether to use color in the helm output. Defaults to `true`.

### help

Environment variables:

- `HELP_SHELLBITS_DIR`: the directory where shellbits is installed.

### json

Environment variables:

- `JSON_SHELLBITS_DIR`: the directory where shellbits is installed.
- `JSON_JSONLINT_IMAGE`: the jsonlint image to use. Defaults to `cytopia/jsonlint:1.6.0`.

### kubernetes

- `KUBERNETES_SHELLBITS_DIR`: the directory where shellbits is installed.

### markdown

- `MARKDOWN_SHELLBITS_DIR`: the directory where shellbits is installed.
- `MARKDOWN_MARKDOWNLINT_IMAGE`: the markdownlint image to use. Defaults to `davidanson/markdownlint-cli2:v0.6.0`.

### mkfile

- `MKFILE_SHELLBITS_DIR`: the directory where shellbits is installed.
- `MKFILE_MAKEFILELINT_IMAGE`: the checkmake image to use. Defaults to `cytopia/checkmake:latest-0.5`.

### shell

- `SHELL_SHELLBITS_DIR`: the directory where shellbits is installed.
- `SHELL_SHELLCHECK_IMAGE`: the shellcheck image to use. Defaults to `koalaman/shellcheck:v0.9.0`.
- `SHELL_SHFMT_IMAGE`: the shfmt image to use. Defaults to `mvdan/shfmt:v3`.

### tilt

- `TILT_SHELLBITS_DIR`: the directory where shellbits is installed.
- `TILT_PROJECT_NAME`: the name of the project used by all tilt targets and scripts.
- `TILT_FORCE`: activate the force flag on any command that supports it.
- `FORCE`: activate the force flag on any command that supports it.

#### down

Environment variables:

- `TILT_DOWN_PROJECT_NAME`: the name of the project used by tilt. defaults to the name of the folder from where the script is called from.
- `TILT_DOWN_FORCE`: force the destruction of the tilt's image registry.

#### start

Environment variables:

- `TILT_START_PROJECT_NAME`: the name of the project used by tilt. defaults to the name of the folder from where the script is called from.

#### stop

Environment variables:

- `TILT_STOP_PROJECT_NAME`: the name of the project used by tilt. defaults to the name of the folder from where the script is called from.

#### up

Environment variables:

- `TILT_UP_PROJECT_NAME`: the name of the project used by tilt. defaults to the name of the folder from where the script is called from.
- `TILT_UP_PROJECT_DOMAIN`: the domain of the project used by tilt. defaults to `<TILT_PROJECT_NAME>.dev`.
- `TILT_UP_FORCE`: recreates the certificates and other transient resources.
- `TILT_UP_SETUP_TLS_CERTS`: setup the self-signed tls certificates for the project.
- `TILT_UP_WORKING_DIR`: the working directory for the tilt project. defaults to the folder where the script is called from.
- `TILT_UP_CONFIGS_DIR`: the directory where the tilt configurations for the project are stored. defaults to `${WORKING_DIR}/hack/develop`.

### yaml

- `YAML_SHELLBITS_DIR`: the directory where shellbits is installed.
- `YAML_YAMLLINT_IMAGE`: the yamllint image to use. Defaults to `cytopia/yamllint:1`.

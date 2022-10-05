# Variables

PRODUCT_NAME := SwiftUIArchitectureMVVM
WORKSPACE_NAME := ${PRODUCT_NAME}.xcworkspace

TOOLS_PACKAGE_PATH := Tools
TOOLS_PATH := ${TOOLS_PACKAGE_PATH}/.build/release

BINARIES_PACKAGE_PATH := Binaries

SWIFTLINT_VERSION := 0.49.1

SWIFTLINT_ARTIFACTBUNDLE_NAME := SwiftLintBinary.artifactbundle
SWIFTLINT_ARTIFACTBUNDLE_ZIP_NAME := ${SWIFTLINT_ARTIFACTBUNDLE_NAME}.zip
SWIFTLINT_PATH := ${BINARIES_PACKAGE_PATH}/${SWIFTLINT_ARTIFACTBUNDLE_NAME}/swiftlint-${SWIFTLINT_VERSION}-macos/bin

# Targets

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":[^#]*? #| #"}; {printf "%-36s%s\n", $$1 $$3, $$2}'

.PHONY: setup
setup: # Install dependencies and prepared development configuration
	$(MAKE) build-tools
	$(MAKE) download-tools
	$(MAKE) open

.PHONY: build-tools
build-tools: # Build CLI tools managed by Swift Package Manager
#	$(MAKE) build-tool TOOL_NAME=swiftlint
	$(MAKE) build-tool TOOL_NAME=swiftgen

.PHONY: build-tool
build-tool:
	swift build -c release --package-path ${TOOLS_PACKAGE_PATH} --product ${TOOL_NAME}

.PHONY: download-tools
download-tools:
	$(MAKE) download-swiftlint-artifactbundle

.PHONY: download-swiftlint-artifactbundle
download-swiftlint-artifactbundle: # Download SwiftLint Binary
	curl -o ${BINARIES_PACKAGE_PATH}/${SWIFTLINT_ARTIFACTBUNDLE_ZIP_NAME} https://github.com/realm/SwiftLint/releases/download/${SWIFTLINT_VERSION}/SwiftLintBinary-macos.artifactbundle.zip -L
	unzip ${BINARIES_PACKAGE_PATH}/${SWIFTLINT_ARTIFACTBUNDLE_ZIP_NAME} -d ${BINARIES_PACKAGE_PATH}
	rm -f ${BINARIES_PACKAGE_PATH}/${SWIFTLINT_ARTIFACTBUNDLE_ZIP_NAME}

.PHONY: open
open: # Open workspace in Xcode
	open ./${WORKSPACE_NAME}

.PHONY: swiftgen
swiftgen: # Use SwiftGen
	${TOOLS_PATH}/swiftgen

.PHONY: swiftlint
swiftlint: # Use SwiftLint
	${SWIFTLINT_PATH}/swiftlint

.PHONY: format
format: # Use SwiftLint format
	$(MAKE) swiftlint --fix --format --quiet

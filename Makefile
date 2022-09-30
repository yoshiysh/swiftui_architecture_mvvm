# Variables

PRODUCT_NAME := SwiftUIArchitectureMVVM
WORKSPACE_NAME := ${PRODUCT_NAME}.xcworkspace

TOOLS_PACKAGE_PATH := Tools
TOOLS_PATH := ${TOOLS_PACKAGE_PATH}/.build/release

# Targets

.PHONY: setup
setup:
	$(MAKE) build-tools
	$(MAKE) open

.PHONY: build-tools
build-tools:
	$(MAKE) build-tool TOOL_NAME=swiftlint

.PHONY: build-tool
build-tool:
	swift build -c release --package-path ${TOOLS_PACKAGE_PATH} --product ${TOOL_NAME}

.PHONY: open
open:
	open ./${WORKSPACE_NAME}

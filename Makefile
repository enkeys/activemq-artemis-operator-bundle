#!make

SHELL := /bin/sh -x

all: clean build prepare-image-check validate
verify-image: clean pull prepare-image-check validate

all-ci: clean build prepare-image-check validate-ci
verify-image-ci: clean prepare-image-check validate-ci

build:
	@set -a; . ./.env; \
	docker build . -f bundle.Dockerfile \
	--build-arg NAME="$$BUNDLE_NAME"  \
	--build-arg VERSION="$$BUNDLE_VERSION"  \
	--build-arg DESCRIPTION="$$BUNDLE_DESCRIPTION"  \
	--build-arg SUMMARY="$$BUNDLE_SUMMARY"  \
	--build-arg REDHAT_OPENSHIFT_VERSION="$$REDHAT_OPENSHIFT_VERSION"  \
	--build-arg REDHAT_COMPONENT="$$BUNDLE_REDHAT_COMPONENT"  \
	--build-arg OPENSHIFT_TAGS="$$BUNDLE_OPENSHIFT_TAGS"  \
	--build-arg K8S_DISPLAY_NAME="$$BUNDLE_K8S_DISPLAY_NAME"  \
	--build-arg K8S_DESCRIPTION="$$BUNDLE_K8S_DESCRIPTION"  \
	--build-arg OPERATOR_PACKAGE="$$OPERATOR_PACKAGE" \
	-t $$IMAGE_BUNDLE \

pull:
	@set -a; . ./.env; \
	docker pull $$IMAGE_BUNDLE

prepare-image-check:
	@set -a; . ./.env; \
	tests/scripts/prepare.sh $$IMAGE_BUNDLE

validate:
	@set -a; . ./.env; \
	goss validate

validate-ci:
	@set -a; . ./.env; \
	goss validate --format documentation --format-options verbose; \
	goss validate --format junit --format-options verbose > validate_results.junit.xml
	sh tests/scripts/junit.sh validate_results.junit.xml

clean:
	@rm -rf tests/verify

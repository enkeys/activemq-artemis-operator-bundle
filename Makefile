#!make

SHELL := /bin/sh -x

all: clean build prepare-image-check validate
verify-image: clean pull prepare-image-check validate

all-ci: clean build prepare-image-check validate-ci
verify-image-ci: clean prepare-image-check validate-ci

build:
	@set -a; . ./.env; \
	docker build . -f bundle.Dockerfile -t $${TARGET_IMAGE}

pull:
	@set -a; . ./.env; \
	docker pull $${TARGET_IMAGE}

prepare-image-check:
	@set -a; . ./.env; \
	tests/scripts/prepare.sh $${TARGET_IMAGE}

validate:
	@set -a; . ./.env; \
	goss validate

validate-ci:
	@set -a; . ./.env; \
	goss validate --format documentation --format-options verbose; \
	goss validate --format junit --format-options verbose > validate_results.junit.xml; \
	tests/scripts/junit.sh validate_results.junit.xml

clean:
	@rm -rf tests/verify

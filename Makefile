# enable BASH-specific features
SHELL := /bin/bash

SOURCE_DIR := $(shell pwd)
SERVICE_DIR := services

SERVICES := $(foreach dir, $(SERVICE_DIR), $(wildcard $(SERVICE_DIR)/*))

.PHONY: vet
vet:
	@./gradlew verifyGoogleJavaFormat

.PHONY: fmt
fmt:
	@./gradlew googleJavaFormat

.PHONY: cov
cov:
	@./gradlew jacocoTestReport

.PHONY: test
test: vet
	@./gradlew check

.PHONY: jar
jar:
	@./gradlew bootJar

.PHONY: clean
clean:
	@./gradlew clean

.PHONY: image
image:
	@docker build --force-rm -t cubic/base-service .

.PHONY: images
images: jar
	@echo "build microservice docker images"
	@for subdir in $(SERVICES); \
		do \
		  m=`echo $$subdir | cut -d/ -f 2`; \
		  echo "build docker image for $$m"; \
		  cd $(SOURCE_DIR)/$$subdir; docker build --force-rm -t cubic/$$m .; \
		done

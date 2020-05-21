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

.PHONY: unit-test
unit-test:
	@./gradlew test -PexcludeTests='**/GatewayIntegrationTest.class'

.PHONY: integration-test
integration-test:
	@./gradlew test -Dtest.single=GatewayIntegrationTest

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
		  echo -e "\n==> build docker image for '$$m' <==\n"; \
		  cd $(SOURCE_DIR)/$$subdir; docker build --force-rm -t cubic/$$m .; \
		done

.PHONY: init
init:
	@docker volume create postgres_database
	@docker volume create redis_database

.PHONY: env-up
env-up:
	@docker-compose -f docker-compose.yml up -d --force-recreate

.PHONY: env-down
env-down:
	@docker-compose -f docker-compose.yml down --remove-orphans

.PHONY: prune
prune:
	@docker volume rm redis_database
	@docker volume rm postgres_database

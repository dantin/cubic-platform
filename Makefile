# enable BASH-specific features
SHELL := /bin/bash

SOURCE_DIR  := $(shell pwd)
SERVICE_DIR := services
TAG_VERSION ?= "latest"

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

.PHONY: dist
dist:
	@test -d dist || mkdir dist
	@cat standalone.yml | sed -e 's/cubic\//dding\/usapp-/g' > dist/standalone.yml
	@cp -r data dist
	@zip -r dist.zip dist
	@rm -rf dist

.PHONY: unit-test
unit-test: vet
	@./gradlew test -PexcludeTests='**/GatewayIntegrationTest.class'

.PHONY: test
test: vet
	@./gradlew check

.PHONY: jar
jar:
	@./gradlew bootJar

.PHONY: clean
clean:
	@./gradlew clean
	@rm -rf dist.zip

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

.PHONY: publish-images
publish-images:
	@for subdir in $(SERVICES); \
		do \
		  m=`echo $$subdir | cut -d/ -f 2`; \
		  tag=`echo "dding/usapp-"$$m":${TAG_VERSION}"`; \
		  docker tag cubic/$$m $$tag; \
		  docker push $$tag; \
		done

.PHONY: prune-images
prune-images:
	@for subdir in $(SERVICES); \
		do \
		  m=`echo $$subdir | cut -d/ -f 2`; \
		  tag=`echo "dding/usapp-"$$m":${TAG_VERSION}"`; \
		  docker rmi -f $$tag; \
		done

.PHONY: setting
setting:
	@echo "building .env file"
	@echo -e "CODE_PATH=$(SOURCE_DIR)" > .env
	@cat env >> .env

.PHONY: init
init: setting
	@echo "building docker volume"
	@docker volume create postgres_database
	@docker volume create redis_database
	@docker volume create rabbitmq_data

.PHONY: env-up
env-up:
	@docker-compose -f docker-compose.yml up -d --force-recreate

.PHONY: env-down
env-down:
	@docker-compose -f docker-compose.yml down --remove-orphans

.PHONY: standalone-up
standalone-up:
	@docker-compose -f standalone.yml up -d --force-recreate

.PHONY: standalone-down
standalone-down:
	@docker-compose -f standalone.yml down --remove-orphans

.PHONY: prune
prune:
	@docker volume rm redis_database
	@docker volume rm postgres_database
	@docker volume rm rabbitmq_data

.PHONY: vet
vet:
	@./gradlew verifyGoogleJavaFormat

.PHONY: fmt
fmt:
	@./gradlew googleJavaFormat

.PHONY: test
test: vet
	@./gradlew test

.PHONY: jar
jar:
	@./gradlew bootJar

.PHONY: clean
clean:
	@./gradlew clean

.PHONY: docker
docker: jar
	docker build --force-rm -t apm/ultrasound-server .

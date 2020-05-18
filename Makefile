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

.PHONY: docker
docker: jar
	@ docker build --force-rm -t apm/ultrasound-server .

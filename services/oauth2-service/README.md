# OAuth2 Service

## Table of Content

- [How to](#how-to)
- [Resources](#resources)

## How to

Generate keystore:

    $ keytool -genkeypair -alias ultrasound -keyalg RSA -keypass password -keystore keystore.jks -storepass password

Export public key:

    $ keytool -list -rfc --keystore keystore.jks | openssl x509 -inform pem -pubkey -noout

## Resources

Spring Security OAuth [Database Schema](https://github.com/spring-projects/spring-security-oauth/blob/spring-security-oauth2/src/test/resources/schema.sql)

## Test

    curl -v -u ultrasound_service:password -X POST "localhost:8083/oauth/token?grant_type=password&username=room01&password=password"
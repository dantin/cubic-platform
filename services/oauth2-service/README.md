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

developers.redhat.com/blog/2020/01/29/api-login-and-jwt-token-generation-using-keycloak

## Test

    curl -v -u ultrasound_service:password -X POST "localhost:8083/oauth/token?grant_type=password&username=room01&password=password"
    curl -L -X POST 'http://localhost:8083/auth/realms/cubic/protocol/openid-connect/token' -H 'Content-Type: application/x-www-form-urlencoded' --data-urlencode 'client_id=ultrasound_api_client' --data-urlencode 'grant_type=password' --data-urlencode 'client_secret=password' --data-urlencode 'scope=read' --data-urlencode 'username=room01' --data-urlencode 'password=password' | jq
    curl localhost:10001/ultrasound/user/profile -H "Authorization: Bearer $CODE"

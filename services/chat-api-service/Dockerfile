FROM cubic/base-service:latest
MAINTAINER david chengjie.ding@gmail.com

ADD build/libs/chat-api-service-1.0.0-RELEASE.jar /app/app.jar
RUN chown admin:admin /app

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 8080
CMD ["server"]

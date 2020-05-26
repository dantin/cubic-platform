FROM cubic/base-service:latest
MAINTAINER david chengjie.ding@gmail.com

ADD build/libs/room-service-1.0.1-SNAPSHOT.jar /app/app.jar
RUN chown admin:admin /app

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 8080
CMD ["server"]

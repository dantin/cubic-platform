FROM tomcat:9.0.21-jdk8-adoptopenjdk-hotspot

# Configure the UAA
# CLOUD_FOUNDRY_CONFIG_PATH is detailed here:
#   https://docs.cloudfoundry.org/concepts/architecture/uaa.html#custom-configuration
# and here:
#   https://github.com/cloudfoundry/uaa/blob/master/docs/Sysadmin_Guide.rst
ENV CLOUD_FOUNDRY_CONFIG_PATH=$CATALINA_HOME/temp/uaa
RUN mkdir -p $CLOUD_FOUNDRY_CONFIG_PATH
COPY uaa.yml $CLOUD_FOUNDRY_CONFIG_PATH

# Configure Tomcat
COPY cloudfoundry-identity-uaa-4.30.0.war $CATALINA_HOME/webapps/uaa.war
COPY tomcat-users.xml $CATALINA_HOME/conf
COPY server.xml $CATALINA_HOME/conf
COPY manager.xml $CATALINA_HOME/webapps/manager/META-INF/context.xml
COPY host-manager.xml $CATALINA_HOME/webapps/host-manager/META-INF/context.xml

# Set the Spring profile and run Tomcat
ENV SPRING_PROFILES_ACTIVE=default,hsqldb
CMD ["catalina.sh", "run"]

# Tomcat will start on port 8090 – but don't forget to publish a port on the host when you run!
EXPOSE 8090

# To build use `docker build --tag uaa .`
# To run use `docker run -p 8888:8090 --name=uaa uaa`
# To test use `http://localhost:8888/uaa/login` User: tomtac Password: password

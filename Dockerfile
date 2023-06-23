FROM registry.access.redhat.com/ubi8/ubi-minimal:8.5

LABEL BASE_IMAGE="registry.access.redhat.com/ubi8/ubi-minimal:8.5"
LABEL JAVA_VERSION="11"

RUN microdnf install --nodocs java-11-openjdk-headless && microdnf clean all

WORKDIR /
COPY target/*.jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
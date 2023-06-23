FROM openjdk:8-jdk

RUN mkdir /app

WORKDIR /app

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
FROM maven:3.5-jdk-11 AS build
COPY src /usr/src/app/src  
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean install


FROM openjdk:11-jre-slim-buster
COPY --from=build /usr/src/app/target/demo-0.0.1-SNAPSHOT.jar /usr/app/spring-app.jar
EXPOSE 8080
# COPY --from=build /usr/src/app/target/lib /usr/app/lib
ENTRYPOINT ["java","-jar","/usr/app/spring-app.jar"]

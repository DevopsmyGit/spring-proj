# Stage 1: Build the application with Maven
FROM maven:3.8.4-openjdk-11 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src /app/src
RUN mvn clean install

# Stage 2: Create the final image with only the JRE and the compiled application
FROM openjdk:11-jre-slim
EXPOSE 8082
COPY --from=builder /app/target/spring-k8s.jar /app/spring-k8s.jar
ENTRYPOINT ["java", "-jar", "/app/spring-k8s.jar"]



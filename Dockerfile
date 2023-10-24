FROM openjdk:17-alpine
EXPOSE 8080
ADD target/spring-k8s.jar spring-k8s.jar
ENTRYPOINT [ "java", "-jar", "spring-k8s.jar" ]



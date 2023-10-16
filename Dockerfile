FROM adoptopenjdk:17-jre-hotspot
EXPOSE 8080
ADD target/spring-k8s.jar spring-k8s.jar
ENTRYPOINT [ "java", "-jar", "spring-k8s.jar" ]



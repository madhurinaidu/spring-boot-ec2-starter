FROM openjdk:8-jdk-alpine
COPY target/spring-boot-ec2-starter.jar spring-boot-ec2-starter.jar
ENTRYPOINT ["java","-jar","/spring-boot-ec2-starter.jar"]

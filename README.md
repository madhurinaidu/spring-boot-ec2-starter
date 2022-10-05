## Deploying Spring Boot Application with MySQL on AWS EC2 using Docker

In our local system, we deploy Spring Boot application usings tomcat but with this example, you'll know how you can deploy a Spring Boot application on AWS using Docker and the application would be easily available through a public IP which can be accessed from anywhere.
 
Follow these steps for the deployment.

1. Pull the project from repository
2. Generate docker image from project by first generating the JAR/WAR file
3. Pushing the docker image on docker hub
4. Logging into AWS Console and setting up the instance
5. Installing Docker and Docker Compose on the instance
6. Pull docker image from docker hub on the instance
7. Run both Spring Boot and MySQL container using Docker Compose
8. Setting port on AWS EC2 instance
9. Start the application

Project repository:

```
git clone https://gitlab.com/rohitsuthar1/spring-boot-aws-starter
```

```
## Localhost Database Configuration
spring.datasource.url = jdbc:mysql://db:3306/springbootdb?useSSL=false&allowPublicKeyRetrieval=true
spring.datasource.username = root
spring.datasource.password = root
```

In the database source URL, you've to mention the name of the MySQL container so that the Spring Boot container can connect to the database as you have to omit the localhost here. After modifying the database credentials if you need, you have to generate the JAR file for the project using the below command.

```
mvn clean package
```

This will generate the JAR file in the target folder which will be input for your Dockerfile. Now build the Docker Image from the project using the below command.

```
docker build -t {docker-hub-username}/spring-boot-app:1.0 .
```

Note: Replace {docker-hub-username} with docker hub username.

Now you have to push this image on to the Docker Hub because the EC2 instance can't take the image from your local machine. EC2 instance will take both the above generated image and mysql image from the Docker Hub when we run the project.

To push on to the Docker Hub, use this command:

```
docker push {docker-hub-username}/spring-boot-app:1.0
```

Now, it's time to move on the virtual machine that is AWS EC2 instance. Follow these steps to set up the instance.

1. Login into AWS account
2. Click on Services and then EC2 under Compute
3. Click on Instances(Running)
4. Click on Launch Instances
5. Select the Machine Image from the list(Choose Amazon Linux 2 AMI)
6. Click on Review and Launch (Make sure you've chosen free tier and not using any paid service)
7. Click on Launch
8. Create your new key pair and download it on your machine
9. Now select the instance and click on the connect and follow the instruction
10. Navigate to the keypair file where you have downloaded
11. Hit the ssh command

You'll be entered into the remote shell of your EC2 instance and here you need to download everything as it's a new machine so install Docker, Maven, Docker-Compose and also other required applications.

Now clone the project from the GitHub URL in the EC2 instance terminal.

```
git clone https://gitlab.com/rohitsuthar1/spring-boot-aws-starter
```

Now pull the Spring Boot project from Docker Hub and also the MySQL Image using below commands

```
docker pull {docker-hub-username}/spring-boot-app.1:0
docker pull mysql:5.7
```

Now navigate to the project in the EC2 terminal and run the docker-compose file using the below command

```
docker-compose up -d
```

This will run both the Spring Boot and MySQL container and you can check them using docker ps command. The Spring Boot application runs on the 8080 port hence you have to add the 8080 port in your EC2 instance security groups.

1. Go the Inbound rules
2. Edit inbound rules
3. Add a new rule
4. Select type as Custom TCP and set protocol as TCP
6. Select port range as 8080
7. Select source as custom
8. Save rules

That's it, your application is now ready to be accessed. Copy the Public IPv4 DNS and open this URL

Note: Add the respective port at the end of URL, for this put :8080 after the public URL

I hope this tutorial helped you in setting up the first Spring Boot application with database connection on AWS using Docker.

## Deploying spring boot app with mysql on aws ec2 instance with docker

Follow these steps for the deployment.

1. Clone the project - git clone https://github.com/rosuth/spring-boot-ec2-starter
2. Generate docker image of project
3. Push generated docker image onto docker hub
4. Setup an ec2 instance on aws and ssh into it
5. Installing docker, docker-compose, java, maven etc on the instance
6. Pull the docker image from hub in instance
7. Start both app and mysql container with docker-compose
8. Update security group

```
spring.datasource.url = jdbc:mysql://db:3306/demo?useSSL=false&allowPublicKeyRetrieval=true
spring.datasource.username = root
spring.datasource.password = root
```
Use the mysql container name in place of localhost to connect your application container with mysql container
Build project and generate new artifact to update changes

Now build the docker image

```
docker build -t {docker-hub-username}/spring-boot-ec2-starter:1.0 .
```

Once image is built, push it onto the docker hub, no need to push the mysql image since it's already available on docker hub

```
docker push {docker-hub-username}/spring-boot-ec2-starter:1.0
```

Now ssh into the aws ec2 instance and install the required applications
Clone this repo from github into instance
Pull images from docker hub

```
docker pull {docker-hub-username}/spring-boot-ec2-starter.1:0
docker pull mysql:5.7
```

Run the docker-compose file from project directory

```
docker-compose up -d
```

Check running containers with "docker ps" command

The application should be accessible now!
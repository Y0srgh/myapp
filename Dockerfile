# Step 1: Use an official lightweight JDK base image
FROM openjdk:17-jdk-alpine

# Step 2: Set a working directory inside the container
WORKDIR /app

# Step 3: Copy the jar file built by Maven into the container
COPY target/*.jar app.jar

# Step 4: Expose the application port (default for Spring Boot is 8081)
EXPOSE 8081

# Step 5: Define the command to run your app
ENTRYPOINT ["java","-jar","app.jar"]

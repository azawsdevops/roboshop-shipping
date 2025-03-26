#FROM            openjdk
#RUN             useradd java
#USER            java
#WORKDIR         /home/java
#COPY            target/shipping-1.0.jar shipping.jar
#ENTRYPOINT      [ "java", "-jar", "shipping.jar" ]
# First stage: Build the JAR
FROM maven:3.8.6-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Second stage: Run the app
FROM openjdk:17
WORKDIR /home/java
COPY --from=builder /app/target/shipping-1.0.jar shipping.jar
ENTRYPOINT [ "java", "-jar", "shipping.jar" ]

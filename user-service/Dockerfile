# Multi-stage Dockerfile for user-service (Java 17 / Maven build)

# Builder stage: compile the application using Maven
FROM maven:3.8.8-openjdk-17 AS builder
WORKDIR /build

# Copy maven configuration and source
COPY pom.xml .
COPY src ./src

# Download dependencies and build the application (skip tests to speed up CI/local builds)
RUN mvn -B -DskipTests dependency:go-offline
RUN mvn -B -DskipTests package

# Runtime stage: minimal JRE image
FROM openjdk:17-jdk-slim
WORKDIR /app

# Optional: environment variable for additional JVM options
ENV JAVA_OPTS=""

# Expose the application's default port
EXPOSE 8080

# Copy the built jar from the builder stage. Assumes the build produced a single runnable jar in target/
COPY --from=builder /build/target/*.jar /app/app.jar

# Run the application
ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar /app/app.jar"]


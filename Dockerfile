# Build stage: compile the Spring Boot application
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /workspace
COPY pom.xml .
COPY src ./src
RUN mvn -B clean package -DskipTests

# Runtime stage: run the packaged application
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /workspace/target/app-service.jar app-service.jar
EXPOSE 8000
ENTRYPOINT ["java", "-jar", "app-service.jar"]

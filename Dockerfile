# Build stage
FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /app
COPY HelloWorld.java .
RUN javac HelloWorld.java

# Runtime stage
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/HelloWorld.class .
CMD ["java", "HelloWorld"]

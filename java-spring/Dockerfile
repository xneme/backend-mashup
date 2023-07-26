FROM bellsoft/liberica-runtime-container:jdk-17-musl AS builder
WORKDIR /app
COPY . .
RUN ./gradlew build

FROM bellsoft/liberica-runtime-container:jdk-17-musl
WORKDIR /app
COPY --from=builder /app/build/libs/java-spring-0.0.1.jar java-spring.jar
ENTRYPOINT [ "java", "-jar", "java-spring.jar" ]


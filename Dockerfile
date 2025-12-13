FROM maven:amazoncorretto AS MAVEN_BUILD
COPY ./pom.xlm ./pom.xml
RUN mvn dependency:go-offline -B
COPY ./src ./src
RUN mvn clean package

FROM eclipse-temurin:17-jre
EXPOSE 8080
COPY --from=MAVEN_BUILD target/*.jar /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
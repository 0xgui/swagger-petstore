FROM openjdk:8-jre-alpine

WORKDIR /swagger-petstore

RUN addgroup -S swagger -g 1000 && adduser -S swagger -G swagger -u 1000 \
    && mkdir logs \ 
    && chown -R 1000:1000 logs
COPY --chown=1000:1000 target/lib/jetty-runner.jar /swagger-petstore/jetty-runner.jar
COPY --chown=1000:1000 target/*.war /swagger-petstore/server.war
COPY --chown=1000:1000 src/main/resources/openapi.yaml /swagger-petstore/openapi.yaml
COPY --chown=1000:1000 inflector.yaml /swagger-petstore/
 
EXPOSE 8080
USER swagger:swagger
CMD ["java", "-jar", "-DswaggerUrl=openapi.yaml", "/swagger-petstore/jetty-runner.jar", "--log", "logs/yyyy_mm_dd-requests.log", "/swagger-petstore/server.war"]

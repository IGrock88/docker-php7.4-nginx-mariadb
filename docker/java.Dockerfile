FROM maven:3.6.3-openjdk-11 as build

WORKDIR /var/java/app
COPY /java/. /var/java/app/

RUN mvn -T 4 clean compile assembly:single

FROM mcr.microsoft.com/java/jre:11-zulu-debian10

COPY /java/. /var/java/app/
COPY --from=build /var/java/app/target /var/java/app/target

WORKDIR /var/java/app/target

CMD ["java", "-Dfile.encoding=UTF-8", "-Xms4096m", "-Xmx4096m", "-DdbPath=/var/java/app/src/main/resources/monitoring.s3db", "-jar", "Monitoring-1.0-jar-with-dependencies.jar"]

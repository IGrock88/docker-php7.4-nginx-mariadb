FROM maven:3.6.3-openjdk-11

WORKDIR /var/java/app
COPY /java/. /var/java/app/

RUN mvn install:install-file -Dfile=/var/java/app/libfptr10.jar -DgroupId=libfptr -DartifactId=libfptr-sdk -Dversion=10.8.0.0 -Dpackaging=jar
RUN mvn clean compile assembly:single
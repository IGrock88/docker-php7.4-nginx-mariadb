FROM mcr.microsoft.com/java/jre:11-zulu-debian10

RUN mkdir -p /var/java/app/target/logs

WORKDIR /var/java/app/target

RUN java -jar CheckPrinter-1.0-jar-with-dependencies.jar
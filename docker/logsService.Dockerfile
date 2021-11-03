FROM mongo

RUN apt-get -y update
RUN apt-get install -y nodejs npm
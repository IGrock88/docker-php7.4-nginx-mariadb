FROM node:16.3.0

WORKDIR /usr/src/app
COPY ./logs/ /usr/src/app
RUN npm install
RUN npm start
CMD ["node", "server.js"]

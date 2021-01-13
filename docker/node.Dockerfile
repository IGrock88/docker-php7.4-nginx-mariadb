FROM node:latest

# Update
RUN apt-get update -y

# Install apt-transport-https for Yarn repository
RUN apt-get install apt-transport-https -y

# Add Yarn repository
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Update
RUN apt-get update -y

# Install Yarn
RUN apt-get install yarn -y

WORKDIR /var/www/html

COPY ./www/package.json /www/babel.config.js ./www/postcss.config.js ./www/webpack.common.js ./www/webpack.dev.js ./www/webpack.prod.js ./www/assets/ ./

#RUN yarn install
#COPY . ./
#RUN yarn run build
#COPY ./www/babel.config.js ./www/postcss.config.js ./www/webpack.common.js ./www/webpack.dev.js ./www/webpack.prod.js ./
#RUN yarn build

# CMD ["npm", "run", "start"]
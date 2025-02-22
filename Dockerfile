FROM node:18-alpine

RUN apk update
RUN apk upgrade
RUN set -ex; apk add --no-cache --virtual .fetch-deps curl tar git ;

WORKDIR /app

COPY package.json /app

RUN npm install -g npm
RUN npm install --production
RUN npm audit fix --production

# RUN npm install --production --no-audit

RUN rm -rf /usr/local/lib/node_modules/npm/node_modules/node-gyp/test

COPY . .

RUN mkdir /app/uploads

ENV IMAGE_TAG=__image_tag__

EXPOSE 9080

RUN chmod 777 /app

RUN chmod 777 /app/uploads

CMD node app.js
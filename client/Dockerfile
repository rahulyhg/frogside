FROM node:6-alpine

COPY . /app
WORKDIR /app

RUN npm install

EXPOSE 7200

ENTRYPOINT ["npm"]

COMMAND ["start"]

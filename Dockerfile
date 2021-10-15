FROM node:10-alpine

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install --production && npm install dotenv

COPY . .

EXPOSE 5000

CMD node app.js


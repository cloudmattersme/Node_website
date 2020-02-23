FROM node:9

WORKDIR /app


COPY package.json .
RUN npm install

COPY . .

USER node
EXPOSE 3000
CMD ["nodemon","start"]

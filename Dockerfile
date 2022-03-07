FROM node:alpine

WORKDIR /usr/ms-storage

COPY package*.json ./

RUN npm install && npm install typescript

COPY . .

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]

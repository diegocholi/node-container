FROM node:alpine

WORKDIR /usr/cron

RUN echo "--- Instanando chromium dependences ---" && \
    apk update && apk add --no-cache nmap && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache \
    chromium \
    harfbuzz \
    "freetype>2.8" \
    ttf-freefont \
    nss

RUN echo "--- Definindo váriaveis de ambiente ---"
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV CHROMIUM_PATH /usr/bin/chromium-browser

COPY package*.json ./
RUN echo "--- Instando node packeges ---" && \ 
    npm install

RUN echo "--- Copiando arquivos para dentro do container ---"
COPY . .

EXPOSE 80

CMD ["npm", "start"]
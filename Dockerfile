FROM oven/bun:1

WORKDIR /usr/src/app

COPY ./package.json ./

RUN bun install

COPY ./index.js ./

EXPOSE 8000

CMD ["bun", "index.js"]
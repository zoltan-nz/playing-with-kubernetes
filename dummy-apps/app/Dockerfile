xFROM node:alpine
RUN apk add --no-cache libc6-compat curl
EXPOSE 3000

COPY ./package.json /app/
COPY ./*.mjs /app/

WORKDIR app

RUN npm i
CMD ["npm", "start"]

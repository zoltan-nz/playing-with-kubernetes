FROM node:alpine
RUN apk add --no-cache libc6-compat curl yarn
EXPOSE 3000

COPY ./ /app/

WORKDIR app

RUN yarn
CMD ["yarn", "start"]

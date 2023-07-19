FROM node:13.12.0-alpine as builder

RUN mkdir -p /app

WORKDIR  /app

COPY  . /app

RUN npm install 

RUN npm run build

FROM nginx:stable-alpine

WORKDIR /usr/share/nginx/html

RUN rm -rf ./*

COPY --from=builder /app/build .

CMD ["nginx", "-g", "daemon off;" ]
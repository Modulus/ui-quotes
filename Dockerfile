FROM node as builder

WORKDIR /opt/app
COPY . .
RUN npm install && npm run build


FROM nginx as server

WORKDIR /usr/share/nginx/html

RUN rm -drf ./*

COPY --from=builder /opt/app/dist .
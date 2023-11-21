# Stage 1: Build stage
FROM node:21.2.0 as nodework
WORKDIR /myapp

COPY package*.json ./
RUN yarn install

COPY . .

RUN yarn build

# Stage 2: Production stage
FROM nginx:stable-alpine as production-stage
WORKDIR /usr/share/nginx/html

RUN rm -rf ./*
COPY --from=nodework /myapp/build .

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]

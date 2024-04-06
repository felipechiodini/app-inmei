FROM node:18-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:stable-alpine3.17-slim as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 3001

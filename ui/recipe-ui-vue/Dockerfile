# build stage
FROM node:22-alpine AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm i
COPY . .
RUN npm run build

# production stage
FROM nginx:stable-alpine AS production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
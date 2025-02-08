# Stage 1: Compile and build the Angular application
FROM node:22-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm ci

RUN npm i -g @angular/cli

COPY . .

RUN npm i

RUN ng build

# Stage 2: Serve the application with Nginx
FROM nginx:stable

#COPY ./nginx.conf /etc/nginx/nginx.conf

COPY --from=build /app/dist/recipe-ui-angular/browser /usr/share/nginx/html

EXPOSE 80
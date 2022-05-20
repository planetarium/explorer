FROM node:lts-alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .

FROM nginx:stable-alpine as production
COPY --from=builder /app/dist /usr/share/nginx/html
COPY --from=builder /app/ping.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

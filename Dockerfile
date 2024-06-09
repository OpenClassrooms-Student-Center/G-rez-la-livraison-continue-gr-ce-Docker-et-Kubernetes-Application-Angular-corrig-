FROM node:20-slim as BUILDER

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

COPY . .

RUN npm run build

FROM nginx:latest

COPY --from=BUILDER /app/dist/olympic-games-starter/ /app

COPY nginx/nginx.conf /etc/nginx/nginx.conf

USER nginx
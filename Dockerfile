# Aşama 1: Yapılandırma
FROM node:19.7 AS build
WORKDIR /app
COPY package.json ./
COPY package-lock.json ./
RUN npm install
COPY . ./
RUN npm run build
RUN chown -R node:node /app/.next

# Aşama 2: Sunucu
FROM node:19.7-alpine
WORKDIR /app
COPY --from=build /app ./
EXPOSE 3000
CMD ["npm", "start"]


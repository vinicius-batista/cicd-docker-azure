FROM node:16.14 AS builder
WORKDIR /app
COPY ./package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:16.14-alpine

WORKDIR /app
COPY --from=builder /app/package*.json /app/
COPY --from=builder /app/build /app/build
COPY --from=builder /app/public /app/public
RUN npm ci

EXPOSE 3000
CMD ["npm", "start"]
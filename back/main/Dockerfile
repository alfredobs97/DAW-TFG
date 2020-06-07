FROM node:12 AS builder
WORKDIR /app
COPY ./package.json ./
RUN npm install
COPY . .
RUN npm run build


FROM node:12-alpine
WORKDIR /app
COPY --from=builder /app ./
RUN apk add --no-cache bash
RUN chmod +x wait-for-it.sh
CMD ["npm", "run", "start:prod"]
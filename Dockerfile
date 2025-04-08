FROM node:20-alpine

WORKDIR /app

COPY ./package.json ./package.json
COPY ./package-lock.json ./package-lock.json

RUN npm install

COPY . .

ENV DATABASE_URL="postgresql://postgres:mysecret@localhost.docker.internal:5432/postgres"

RUN npx prisma generate
RUN npm run build

EXPOSE 3000

# Run migrations during container startup, not build
CMD npx prisma migrate dev && npm start

FROM node:22.13.1-bullseye AS builder

WORKDIR /app

COPY . .

RUN npm ci

RUN npm run build

FROM node:22.13.1-bullseye AS runner

WORKDIR /app

ENV NODE_ENV=production

# Copy only the necessary files from builder
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
# TODO: Should package.json and node_modules be included in docker container?
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/prisma ./prisma

EXPOSE 3000

CMD ["npm", "start"]

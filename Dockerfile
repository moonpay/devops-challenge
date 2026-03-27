# ---- Build stage ----
FROM node:24-alpine AS build
ARG PRISMA_VERSION=7.3.0
RUN corepack enable && corepack prepare pnpm@latest --activate
WORKDIR /app
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY prisma ./prisma/
RUN pnpm install --frozen-lockfile
COPY . .
ENV NODE_ENV=production
RUN pnpm build

# ---- Production stage ----
FROM node:24-alpine AS production
ARG PRISMA_VERSION=7.3.0
LABEL org.opencontainers.image.source="https://github.com/moonpay/devops-challenge" \
      org.opencontainers.image.description="MoonPay DevOps Challenge - Crypto Prices" \
      org.opencontainers.image.licenses="MIT"
RUN apk add --no-cache dumb-init
ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME=0.0.0.0
WORKDIR /app

# Create non-root user
RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 nextjs

# Install prisma CLI + dotenv for database migrations
WORKDIR /prisma-cli
RUN npm init -y && npm install prisma@${PRISMA_VERSION} dotenv@17.2.3 && \
    npm cache clean --force && \
    chown -R nextjs:nodejs /prisma-cli
WORKDIR /app

# Prisma 7 reads datasource URL from prisma.config.ts
COPY --from=build --chown=nextjs:nodejs /app/prisma.config.ts ./

# Copy prisma schema and migrations
COPY --from=build --chown=nextjs:nodejs /app/prisma ./prisma

# Copy standalone server output
COPY --from=build --chown=nextjs:nodejs /app/public ./public
COPY --from=build --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=build --chown=nextjs:nodejs /app/.next/static ./.next/static

# Copy entrypoint script
COPY --chown=nextjs:nodejs docker-entrypoint.sh ./

USER nextjs

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD ["node", "-e", "fetch('http://localhost:3000/')"]

ENTRYPOINT ["dumb-init", "--", "./docker-entrypoint.sh"]
CMD ["start"]

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

MoonPay DevOps Challenge — a Next.js app displaying cryptocurrency prices, used as a take-home exercise for containerization and Kubernetes deployment.

**Stack**: Next.js 16 (App Router, Turbopack) · TypeScript 5.9 · Prisma 7 · PostgreSQL 17 · Tailwind CSS 4 · pnpm · Turbo

## Common Commands

```bash
pnpm install              # Install dependencies (runs prisma generate via postinstall)
pnpm dev                  # Dev server with Turbopack (http://localhost:3000)
pnpm build                # Production build
pnpm start                # Start production server
pnpm db:migrate           # Run Prisma migrations (requires DATABASE_URL)
pnpm db:push              # Push schema changes without migration files
pnpm db:studio            # Open Prisma Studio GUI
```

Start PostgreSQL locally:
```bash
docker compose up -d postgres
```

Database connection string (see .env.example):
```
POSTGRES_PRISMA_URL="postgres://postgres:postgres@127.0.0.1/currencies?schema=public"
```

No test runner or lint script is currently configured. ESLint config exists (.eslintrc.json extending next/core-web-vitals) but no `lint` script in package.json.

## Architecture

Single Next.js app (not a multi-package monorepo despite Turbo/pnpm-workspace presence).

- **app/page.tsx** — Server Component (force-dynamic), fetches currencies from Prisma and renders them
- **components/table.tsx** — Server Component rendering the currency table
- **components/table-placeholder.tsx** — Loading skeleton for Suspense fallback
- **lib/prisma.ts** — Prisma client configured with `@prisma/adapter-pg` (PostgreSQL driver adapter)
- **prisma/schema.prisma** — Single `currencies` model (id, name, code, icon, price, createdAt)
- **prisma/migrations/** — Initial migration seeds Bitcoin, Dogecoin, Ethereum with prices

## Key Details

- **Node 22 LTS** required (.nvmrc, mise.toml)
- **pnpm** is the package manager (mise.toml manages versions)
- Prisma client is generated into `prisma/generated/` (gitignored) — runs automatically on `pnpm install`
- Tailwind CSS 4 uses CSS-first config in `app/globals.css` with custom theme colors (--color-moonpay, --color-cosmos)
- docker-compose.yaml defines postgres and next services; the Dockerfile does not yet exist (creating it is part of the challenge)
- No CI/CD pipelines; Renovate handles automated dependency updates
- No Kubernetes manifests or IaC yet (part of the challenge)

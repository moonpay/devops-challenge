# Next.js Prisma Starter

A Next.js template using [Prisma](https://prisma.io/) as the ORM.

## Getting Started

### 1. Install Dependencies

```bash
pnpm install
```

### 2. Set Up Environment Variables

Create a `.env` file with your database connection:

```bash
echo 'POSTGRES_PRISMA_URL=postgres://postgres:postgres@localhost:5432/currencies?schema=public' > .env
```

### 3. Start the Database

```bash
docker compose up -d postgres
```

### 4. Seed the Database

```bash
pnpm db:seed
```

### 5. Start Development Server

```bash
pnpm dev
```

The app will be available at [http://localhost:3000](http://localhost:3000).

## Useful Commands

| Command | Description |
|---------|-------------|
| `pnpm dev` | Start the development server |
| `pnpm build` | Build for production |
| `pnpm db:seed` | Push schema and seed the database |
| `pnpm db:studio` | Open Prisma Studio to inspect the database |

## Docker

To run the full stack with Docker:

```bash
docker compose up -d
```

This starts both PostgreSQL and the Next.js app (once we have a Dockerfile)

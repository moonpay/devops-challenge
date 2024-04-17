# Next.js Prisma Starter

This is a simple Next.js template that incorporates [Prisma](https://prisma.io/) as the Object-Relational Mapping (ORM) tool. The following instructions guide you on how to effectively use this template.

## Step-by-step Usage Guide

### Step 1: Clone and Install Dependencies

The first step is to clone this repository and install dependencies. This can be done in a couple ways:

```bash
pnpm create next-app --example https://github.com/moonpay/devops-challenge

# or

git clone https://github.com/moonpay/devops-challenge
cd devops-challenge
pnpm install
```

### Step 2: Set Up Environment Variables

Once you've cloned the project, you need to configure the environment variables. Start by creating a `.env` file by copying the provided `.env.example` file in this directory. You can do this using the command:

```bash
cp .env.example .env
```

Please note that the `.env` file is ignored by Git for security reasons.

### Step 3: Start the Database and Seed Data

Next, you need to start the database and seed the data. You can do this by running the following command:

```bash
docker run --rm --name postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=currencies -p 5432:5432 -d postgres:15

pnpm db:seed

# or

docker compose up -d

pnpm db:seed
```

### Step 4: Start Development Server

Finally, you are ready to run the Next.js development server. Execute the following command in your terminal:

```bash
pnpm dev
```

Once this command runs successfully, the project is up and ready. You might be missing some components (like a Dockerfile), but you can add them as you go.


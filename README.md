# Next.js Prisma Starter

This is a simple Next.js template that incorporates [Prisma](https://prisma.io/) as the Object-Relational Mapping (ORM) tool. The following instructions guide you on how to effectively use this template.

## Step-by-step Usage Guide

### Step 1: Clone and Set Up

The first step is to bootstrap the example using [`create-next-app`](https://github.com/vercel/next.js/tree/canary/packages/create-next-app) and [pnpm](https://pnpm.io/installation). Execute the following command in your terminal:

```bash
pnpm create next-app --example https://github.com/moonpay/devops-challenge
```

### Step 2: Set Up Environment Variables

Once you've cloned the project, you need to configure the environment variables. Start by creating a `.env` file by copying the provided `.env.example` file in this directory. You can do this using the command:

```bash
cp .env.example .env
```
Please note that the `.env` file is ignored by Git for security reasons.

After creating the `.env` file, open it and set the environment variables to match those expected by your database backend. The details of these variables should be provided by your database service provider.

### Step 3: Start Development Server

Finally, you are ready to run the Next.js development server. Execute the following command in your terminal:

```bash
pnpm dev
```

Once this command runs successfully, your Next.js Prisma Starter project is up and ready. You might be missing some components (like a database), but you can add them as you go.

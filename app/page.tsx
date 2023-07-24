import Image from "next/image";
import Link from "next/link";
import { Suspense } from "react";
import Table from "../components/table";
import TablePlaceholder from "../components/table-placeholder";

// Prisma does not support Edge without the Data Proxy currently
// export const runtime = 'edge'
export const preferredRegion = "home";
export const dynamic = "force-dynamic";

export default function Home() {
  return (
    <main className="relative flex min-h-screen flex-col items-center justify-center">
      <h1 className="py-4 bg-gradient-to-br from-black via-cosmos to-moonpay bg-clip-text text-center font-bold tracking-tight text-transparent text-6xl md:text-7xl">
        LatestPrices
      </h1>
      <Suspense fallback={<TablePlaceholder />}>
        {/* @ts-expect-error Async Server Component */}
        <Table />
      </Suspense>
      <p className="font-light text-gray-600 w-full max-w-lg text-center mt-6">
        <Link
          href="https://nextjs.org"
          className="font-medium underline underline-offset-4 hover:text-cosmos transition-colors"
        >
          Next.js
        </Link>{" "}
        demo with{" "}
        <Link
          href="https://prisma.io"
          className="font-medium underline underline-offset-4 hover:text-cosmos transition-colors"
        >
          Prisma
        </Link>{" "}
        as the ORM.
      </p>
      <p className="font-light text-gray-600 w-full max-w-lg text-center mt-2">
        Built with{" "}
        <Link
          href="https://nextjs.org/docs"
          className="font-medium underline underline-offset-4 hover:text-cosmos transition-colors"
        >
          Next.js App Router
        </Link>
        .
      </p>

      <div className="w-full sm:bottom-0 sm:absolute sm:px-20 sm:flex-row py-10 flex flex-col items-center gap-6 justify-between">
        <Link href="https://moonpay.com" className="shrink-0">
          <Image
            src="/moonpay-logo.svg"
            alt="MoonPay Logo"
            width={0}
            height={0}
            sizes="100vw"
            style={{ width: 150, height: "auto" }}
          />
        </Link>
        <Link
          href="https://github.com/moonpay/devops-challenge"
          className="flex shrink-0 justify-center items-center space-x-2"
        >
          <Image src="/github.svg" alt="GitHub Logo" width={24} height={24} />
          <p className="font-light">Source</p>
        </Link>
      </div>
    </main>
  );
}

import localFont from "next/font/local";
import "./globals.css";

export const metadata = {
  title: "DevOps Challenge with Next.js and Prisma",
  description: "A simple Next.js app with Prisma as the ORM",
};

const luna = localFont({
  src: "./fonts/Luna-VF.woff2",
  display: "swap",
  variable: "--font-luna",
  preload: true,
});

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className={luna.variable}>{children}</body>
    </html>
  );
}

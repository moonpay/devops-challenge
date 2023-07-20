import prisma from "@/lib/prisma";
import Image from "next/image";
import RefreshButton from "./refresh-button";

export default async function Table() {
  const startTime = Date.now();
  const currencies = await prisma.currencies.findMany();
  const duration = Date.now() - startTime;

  return (
    <div className="bg-white/30 p-12 shadow-xl ring-1 ring-gray-900/5 rounded-lg backdrop-blur-lg max-w-xl mx-auto w-full">
      <div className="flex justify-between items-center mb-4">
        <div className="space-y-1">
          <h2 className="text-xl font-medium">Recent Currencies</h2>
          <p className="text-sm text-gray-500">
            Fetched {currencies.length} currencies in {duration}ms
          </p>
        </div>
        <RefreshButton />
      </div>
      <div className="divide-y divide-gray-900/5">
        {currencies.map((currency) => (
          <div
            key={currency.name}
            className="flex items-center justify-between py-3"
          >
            <div className="flex items-center space-x-4">
              <Image
                src={currency.icon}
                alt={currency.name}
                width={48}
                height={48}
                className="rounded-full ring-1 ring-gray-900/5"
              />
              <div className="space-y-1">
                <p className="font-medium leading-none">{currency.name}</p>
                <p className="text-sm text-gray-500">
                  {currency.code.toUpperCase()}
                </p>
              </div>
            </div>
            <p className="text-sm font-medium text-gray-800">
              €{currency.price.toFixed(2)}
            </p>
          </div>
        ))}
      </div>
    </div>
  );
}

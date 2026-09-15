import React from 'react';

export const metadata = {
  title: 'Buddy Kottu Admin — Sri Siva General Stores',
  description: 'Store Operations, Order Kanban, Inventory & Delivery Manager',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <head>
        <script src="https://cdn.tailwindcss.com"></script>
        <script
          dangerouslySetInnerHTML={{
            __html: `
              tailwind.config = {
                theme: {
                  extend: {
                    colors: {
                      primary: '#16A34A',
                      accent: '#F97316',
                    }
                  }
                }
              }
            `,
          }}
        />
      </head>
      <body className="bg-slate-50 text-slate-900 font-sans antialiased min-h-screen">
        <div className="flex h-screen overflow-hidden">
          {/* Sidebar */}
          <aside className="w-64 bg-slate-900 text-white flex flex-col border-r border-slate-800">
            <div className="p-5 border-b border-slate-800">
              <h1 className="text-xl font-bold tracking-tight text-emerald-400">
                BUDDY KOTTU
              </h1>
              <p className="text-xs text-slate-400 font-medium">
                Sri Siva General Stores Desk
              </p>
            </div>

            <nav className="flex-1 p-4 space-y-1.5 text-sm font-semibold">
              <a
                href="/"
                className="flex items-center gap-3 px-3 py-2.5 rounded-lg bg-emerald-600 text-white"
              >
                📊 Dashboard & KPIs
              </a>
              <a
                href="/orders"
                className="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-800"
              >
                📦 Order Kanban Workflow
              </a>
              <a
                href="/products"
                className="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-800"
              >
                🛒 Product Catalog
              </a>
              <a
                href="/inventory"
                className="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-800"
              >
                ⚠️ Inventory & Stock Alerts
              </a>
              <a
                href="/delivery"
                className="flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-300 hover:bg-slate-800"
              >
                🛵 Delivery Radius Zones
              </a>
            </nav>

            <div className="p-4 border-t border-slate-800 text-xs text-slate-400">
              <p className="font-bold text-slate-200">GSL Hospital Branch</p>
              <p>Store ID: sri_siva_store_01</p>
              <p className="mt-1 text-emerald-400 font-semibold">● Store Open (6 AM - 10 PM)</p>
            </div>
          </aside>

          {/* Main Workspace Content */}
          <main className="flex-1 overflow-y-auto bg-slate-50 p-8">
            {children}
          </main>
        </div>
      </body>
    </html>
  );
}

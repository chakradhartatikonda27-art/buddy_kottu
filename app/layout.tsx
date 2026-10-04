import type { Metadata } from 'next';
import { Sora, Inter } from 'next/font/google';
import './globals.css';
import { CartProvider } from '@/context/CartContext';

const sora = Sora({
  subsets: ['latin'],
  variable: '--font-sora',
  weight: ['400', '600', '700', '800'],
});

const inter = Inter({
  subsets: ['latin'],
  variable: '--font-inter',
  weight: ['400', '500', '600', '700'],
});

export const metadata: Metadata = {
  title: 'BUDDY MART — Delivering near you',
  description: 'Everything Nearby · Quick delivery snacks, drinks & hostel essentials in 15-30 mins.',
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className={`${sora.variable} ${inter.variable}`}>
      <body className="antialiased bg-[#F8FAFC] min-h-screen text-[#0F172A]">
        <CartProvider>{children}</CartProvider>
      </body>
    </html>
  );
}

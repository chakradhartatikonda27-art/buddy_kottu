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
  title: 'Buddy Kottu — Sri Siva General Stores',
  description: 'Everything Nearby · Quick delivery snacks, drinks & hostel essentials from Sri Siva General Stores.',
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className={`${sora.variable} ${inter.variable}`}>
      <body className="antialiased bg-[#EEF0EC] min-h-screen text-[#111827]">
        <CartProvider>{children}</CartProvider>
      </body>
    </html>
  );
}

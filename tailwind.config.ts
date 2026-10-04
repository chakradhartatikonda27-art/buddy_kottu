import type { Config } from 'tailwindcss';

const config: Config = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        brand: {
          green: '#16A34A',
          dark: '#0B3D24',
          accent: '#F97316',
          surface: '#F6F7F4',
          border: '#E7E9E4',
          text: '#111827',
          muted: '#6B7280',
          bg: '#EEF0EC',
        },
      },
      fontFamily: {
        sora: ['var(--font-sora)', 'sans-serif'],
        inter: ['var(--font-inter)', 'sans-serif'],
      },
      borderRadius: {
        card: '14px',
      },
      boxShadow: {
        phone: '0 24px 60px rgba(11,20,15,.28), 0 2px 8px rgba(11,20,15,.15)',
        cart: '0 8px 20px rgba(11,61,36,.35)',
      },
    },
  },
  plugins: [],
};
export default config;

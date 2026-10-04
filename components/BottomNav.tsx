'use client';

import React from 'react';
import { Home, Grid, Search, ShoppingBag, Receipt, User } from 'lucide-react';
import { useCart } from '@/context/CartContext';
import Link from 'next/link';

export function BottomNav() {
  const { activeView, setActiveView, totalItemsCount, setIsCartDrawerOpen, activeOrderId } = useCart();

  return (
    <div className="md:hidden fixed bottom-0 left-0 right-0 h-16 bg-white border-t border-brand-border flex items-center justify-around z-30 shadow-lg">
      <Link
        href="/"
        onClick={() => setActiveView('home')}
        className={`flex flex-col items-center gap-0.5 text-xs font-semibold ${
          activeView === 'home' ? 'text-brand-green' : 'text-brand-muted hover:text-brand-text'
        }`}
      >
        <Home className="w-5 h-5" />
        <span className="text-[10px]">Home</span>
      </Link>

      <Link
        href="/"
        onClick={() => setActiveView('search')}
        className={`flex flex-col items-center gap-0.5 text-xs font-semibold ${
          activeView === 'search' ? 'text-brand-green' : 'text-brand-muted hover:text-brand-text'
        }`}
      >
        <Search className="w-5 h-5" />
        <span className="text-[10px]">Search</span>
      </Link>

      <button
        onClick={() => setIsCartDrawerOpen(true)}
        className="flex flex-col items-center gap-0.5 text-xs font-semibold text-brand-muted hover:text-brand-text relative"
      >
        <div className="relative">
          <ShoppingBag className="w-5 h-5 text-brand-dark" />
          {totalItemsCount > 0 && (
            <span className="absolute -top-1.5 -right-2 bg-brand-green text-white text-[9px] font-extrabold w-4 h-4 rounded-full flex items-center justify-center">
              {totalItemsCount}
            </span>
          )}
        </div>
        <span className="text-[10px]">Cart</span>
      </button>

      <Link
        href={`/tracking/${activeOrderId}`}
        onClick={() => setActiveView('tracking')}
        className={`flex flex-col items-center gap-0.5 text-xs font-semibold ${
          activeView === 'tracking' ? 'text-brand-green' : 'text-brand-muted hover:text-brand-text'
        }`}
      >
        <Receipt className="w-5 h-5" />
        <span className="text-[10px]">Orders</span>
      </Link>
    </div>
  );
}

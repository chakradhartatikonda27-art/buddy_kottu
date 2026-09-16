'use client';

import React, { useState } from 'react';
import { MapPin, ShoppingBag, Search, Clock, Store, ChevronDown } from 'lucide-react';
import { useCart } from '@/context/CartContext';
import Link from 'next/link';

interface HeaderProps {
  searchQuery: string;
  setSearchQuery: (q: string) => void;
  onOpenSearch?: () => void;
}

export function Header({ searchQuery, setSearchQuery, onOpenSearch }: HeaderProps) {
  const {
    selectedAddress,
    setSelectedAddress,
    totalItemsCount,
    total,
    setIsCartDrawerOpen,
    setActiveView,
  } = useCart();

  const [isAddrDropdownOpen, setIsAddrDropdownOpen] = useState(false);

  const addresses = [
    {
      id: 'addr-hostel',
      label: 'Hostel',
      line1: 'Hostel Block B, Room 214',
      landmark: 'Near GSL Hospital · Landmark: Blue gate',
    },
    {
      id: 'addr-hospital',
      label: 'Hospital',
      line1: 'GSL General Hospital, Ward 3',
      landmark: 'Room 304, 3rd Floor',
    },
    {
      id: 'addr-home',
      label: 'Home',
      line1: 'Flat 402, Sri Siva Residency',
      landmark: 'GSL Hospital Road',
    },
  ];

  return (
    <header className="sticky top-0 z-40 bg-white border-b border-brand-border shadow-sm">
      {/* Top Banner Bar */}
      <div className="bg-brand-dark text-white text-xs px-4 py-1.5 flex items-center justify-between font-medium">
        <div className="flex items-center gap-2">
          <Store className="w-3.5 h-3.5 text-brand-green" />
          <span>Sri Siva General Stores</span>
          <span className="opacity-40">|</span>
          <span className="text-brand-green font-semibold">● Open · closes 10 PM</span>
        </div>
        <div className="hidden md:flex items-center gap-4 text-[11px] opacity-90">
          <span>⚡ 15 Min Delivery to Hostels & Hospital</span>
          <span>📞 Store Helpline: +91 98765 43210</span>
        </div>
      </div>

      {/* Main Header Container */}
      <div className="max-w-7xl mx-auto px-4 py-3 flex items-center justify-between gap-4">
        {/* Brand Logo & Name */}
        <div className="flex items-center gap-3">
          <Link
            href="/"
            onClick={() => setActiveView('home')}
            className="flex items-center gap-2.5 group cursor-pointer"
          >
            <div className="w-10 h-10 rounded-xl bg-brand-dark flex items-center justify-center text-white font-sora font-extrabold text-lg border border-white/20 shadow-sm group-hover:scale-105 transition-transform">
              BK
            </div>
            <div>
              <h1 className="font-sora font-bold text-lg text-brand-dark leading-tight group-hover:text-brand-green transition-colors">
                Buddy Kottu
              </h1>
              <p className="text-[11px] text-brand-muted font-medium">Everything Nearby</p>
            </div>
          </Link>

          {/* Delivery Location Selector */}
          <div className="relative ml-2 sm:ml-4 border-l border-brand-border pl-3 sm:pl-4">
            <button
              onClick={() => setIsAddrDropdownOpen(!isAddrDropdownOpen)}
              className="flex items-center gap-1.5 text-left text-xs hover:bg-brand-surface p-1.5 rounded-lg transition-colors"
            >
              <MapPin className="w-4 h-4 text-brand-green flex-shrink-0" />
              <div>
                <div className="text-[10px] text-brand-muted font-semibold uppercase tracking-wider">
                  Deliver to · {selectedAddress.label}
                </div>
                <div className="font-bold text-xs flex items-center gap-1 text-brand-text truncate max-w-[160px] sm:max-w-[220px]">
                  {selectedAddress.line1}
                  <ChevronDown className="w-3 h-3 text-brand-muted" />
                </div>
              </div>
            </button>

            {/* Address Dropdown */}
            {isAddrDropdownOpen && (
              <div className="absolute top-full left-0 mt-2 w-64 bg-white border border-brand-border rounded-xl shadow-xl z-50 p-2 text-xs">
                <div className="px-2 py-1.5 font-bold text-brand-muted text-[11px] uppercase tracking-wider">
                  Select Delivery Location
                </div>
                {addresses.map((addr) => (
                  <button
                    key={addr.id}
                    onClick={() => {
                      setSelectedAddress(addr);
                      setIsAddrDropdownOpen(false);
                    }}
                    className={`w-full text-left p-2 rounded-lg transition-colors mb-1 ${
                      selectedAddress.id === addr.id
                        ? 'bg-brand-dark text-white font-bold'
                        : 'hover:bg-brand-surface text-brand-text'
                    }`}
                  >
                    <div className="flex items-center gap-1.5">
                      <span>📍</span>
                      <span className="font-bold">{addr.label}</span>
                    </div>
                    <div
                      className={`text-[11px] ${
                        selectedAddress.id === addr.id ? 'text-white/80' : 'text-brand-muted'
                      }`}
                    >
                      {addr.line1}
                    </div>
                  </button>
                ))}
              </div>
            )}
          </div>
        </div>

        {/* Central Search Bar (Desktop / Tablet) */}
        <div className="hidden md:flex flex-1 max-w-md mx-4 relative">
          <div className="w-full flex items-center gap-2 bg-brand-surface border border-brand-border rounded-xl px-3.5 py-2 focus-within:border-brand-green transition-colors">
            <Search className="w-4 h-4 text-brand-muted" />
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Search products, brands, snacks, drinks..."
              className="bg-transparent border-none outline-none text-xs font-medium w-full text-brand-text placeholder-brand-muted"
            />
          </div>
        </div>

        {/* Right Action Controls: Cart & Orders */}
        <div className="flex items-center gap-2 sm:gap-3">
          {/* Cart Button */}
          <button
            onClick={() => setIsCartDrawerOpen(true)}
            className="flex items-center gap-2 bg-brand-dark text-white hover:bg-black transition-colors px-3.5 py-2 rounded-xl text-xs font-bold shadow-sm"
          >
            <ShoppingBag className="w-4 h-4 text-brand-green" />
            <span className="hidden sm:inline">Cart</span>
            <span className="bg-brand-green text-white text-[11px] px-1.5 py-0.5 rounded-md font-bold">
              {totalItemsCount}
            </span>
            <span className="hidden sm:inline opacity-80">· ₹{total}</span>
          </button>
        </div>
      </div>

      {/* Mobile Search Bar Row */}
      <div className="md:hidden px-4 pb-3">
        <div className="flex items-center gap-2 bg-brand-surface border border-brand-border rounded-xl px-3.5 py-2.5">
          <Search className="w-4 h-4 text-brand-muted" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            onFocus={onOpenSearch}
            placeholder="Search products, snacks, drinks..."
            className="bg-transparent border-none outline-none text-xs font-medium w-full text-brand-text placeholder-brand-muted"
          />
        </div>
      </div>
    </header>
  );
}

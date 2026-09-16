'use client';

import React, { useState, useMemo } from 'react';
import { Header } from '@/components/Header';
import { BannerCarousel } from '@/components/BannerCarousel';
import { CategoryChips } from '@/components/CategoryChips';
import { SmartPacks } from '@/components/SmartPacks';
import { ProductCard } from '@/components/ProductCard';
import { ProductDetailModal } from '@/components/ProductDetailModal';
import { CartDrawer } from '@/components/CartDrawer';
import { BottomNav } from '@/components/BottomNav';
import { useCart } from '@/context/CartContext';
import { INITIAL_PRODUCTS, ViewName } from '@/lib/db';
import { Search, ShoppingBag, ArrowRight } from 'lucide-react';
import Link from 'next/link';

export default function HomePage() {
  const {
    activeView,
    setActiveView,
    cart,
    totalItemsCount,
    total,
    setIsCartDrawerOpen,
    activeOrderId,
  } = useCart();

  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('All');

  // Interactive View tabs corresponding to user's demo prompt
  const TABS: { name: ViewName; label: string }[] = [
    { name: 'splash', label: 'Splash' },
    { name: 'home', label: 'Home' },
    { name: 'search', label: 'Search' },
    { name: 'cart', label: 'Cart' },
    { name: 'checkout', label: 'Checkout' },
    { name: 'tracking', label: 'Order Tracking' },
  ];

  // Search & Filter products logic
  const filteredProducts = useMemo(() => {
    let list = [...INITIAL_PRODUCTS];
    if (selectedCategory && selectedCategory !== 'All' && selectedCategory !== 'Offers') {
      list = list.filter((p) => p.category.toLowerCase() === selectedCategory.toLowerCase());
    }
    if (selectedCategory === 'Offers') {
      list = list.filter((p) => p.discountBadge || (p.mrp && p.mrp > p.price));
    }
    if (searchQuery.trim() !== '') {
      const q = searchQuery.toLowerCase().trim();
      list = list.filter(
        (p) =>
          p.name.toLowerCase().includes(q) ||
          p.brand.toLowerCase().includes(q) ||
          p.category.toLowerCase().includes(q) ||
          p.tags.some((t) => t.toLowerCase().includes(q))
      );
    }
    return list;
  }, [searchQuery, selectedCategory]);

  return (
    <div className="min-h-screen pb-20 md:pb-12 bg-[#EEF0EC]">
      {/* Top Demo Header & Tab Bar matching original demo design */}
      <div className="bg-white border-b border-brand-border py-4 px-4 text-center">
        <h1 className="font-sora text-xl sm:text-2xl font-extrabold text-brand-dark">
          Buddy Kottu — Sri Siva General Stores
        </h1>
        <p className="text-xs text-brand-muted mt-1 font-medium">
          Full-Stack Web App · Responsive Desktop, Tablet & Mobile View
        </p>

        {/* Screen switcher tabs */}
        <div className="flex flex-wrap gap-2 justify-center mt-3 max-w-2xl mx-auto">
          {TABS.map((tab) => (
            <button
              key={tab.name}
              onClick={() => {
                setActiveView(tab.name);
                if (tab.name === 'cart') setIsCartDrawerOpen(true);
              }}
              className={`px-3 py-1.5 rounded-full text-xs font-semibold border transition-all ${
                activeView === tab.name
                  ? 'bg-brand-dark text-white border-brand-dark shadow-sm'
                  : 'bg-white text-brand-muted border-brand-border hover:border-brand-green'
              }`}
            >
              {tab.label}
            </button>
          ))}
        </div>
      </div>

      {/* VIEW: SPLASH */}
      {activeView === 'splash' && (
        <div className="max-w-md mx-auto my-8 px-4">
          <div className="h-[580px] rounded-3xl bg-gradient-to-br from-brand-dark to-brand-green flex flex-col items-center justify-center text-white text-center p-6 shadow-2xl relative overflow-hidden">
            <div className="w-20 h-20 rounded-2xl bg-white/15 border-1.5 border-white/30 flex items-center justify-center font-sora font-black text-3xl mb-4 shadow-inner">
              BK
            </div>
            <h2 className="font-sora font-extrabold text-3xl mb-1 tracking-tight">Buddy Kottu</h2>
            <p className="text-sm opacity-90 font-medium mb-6">Everything Nearby</p>
            <div className="text-xs opacity-75 font-medium border-t border-white/20 pt-4">
              Sri Siva General Stores · GSL Hospital Road
            </div>
            <button
              onClick={() => setActiveView('home')}
              className="mt-8 bg-white text-brand-dark font-sora font-bold text-xs px-6 py-3 rounded-full hover:bg-brand-surface transition-transform hover:scale-105 shadow-md"
            >
              Enter Store →
            </button>
          </div>
        </div>
      )}

      {/* VIEW: HOME & SEARCH */}
      {(activeView === 'home' || activeView === 'search') && (
        <>
          <Header
            searchQuery={searchQuery}
            setSearchQuery={(q) => {
              setSearchQuery(q);
              if (q && activeView !== 'search') setActiveView('search');
            }}
            onOpenSearch={() => setActiveView('search')}
          />

          <main className="max-w-7xl mx-auto px-4 sm:px-6 pt-4">
            {/* SEARCH VIEW TOP BLOCK */}
            {activeView === 'search' && (
              <div className="bg-white border border-brand-border rounded-2xl p-4 mb-4 shadow-xs">
                <div className="text-xs font-bold text-brand-muted mb-2">Recent searches</div>
                <div className="flex flex-wrap gap-2 mb-3">
                  {['maggi', 'soap', 'hostel pack', 'cold drink'].map((tag) => (
                    <button
                      key={tag}
                      onClick={() => setSearchQuery(tag)}
                      className="bg-brand-surface hover:bg-brand-border text-brand-text px-3 py-1 rounded-full text-xs font-semibold border border-brand-border transition-colors"
                    >
                      {tag}
                    </button>
                  ))}
                </div>

                <div className="text-xs font-bold text-brand-muted mb-2">Popular searches</div>
                <div className="flex flex-wrap gap-2">
                  {['chips', 'chocolate', 'water bottle', 'biscuits', 'thums up'].map((tag) => (
                    <button
                      key={tag}
                      onClick={() => setSearchQuery(tag)}
                      className="bg-white hover:bg-brand-surface text-brand-text px-3 py-1 rounded-full text-xs font-semibold border border-brand-border transition-colors"
                    >
                      {tag}
                    </button>
                  ))}
                </div>
              </div>
            )}

            {/* PROMO BANNER CAROUSEL */}
            {activeView === 'home' && <BannerCarousel />}

            {/* CATEGORY CHIPS */}
            <CategoryChips
              selectedCategory={selectedCategory}
              onSelectCategory={(cat) => setSelectedCategory(cat)}
            />

            {/* SMART PACKS BUNDLES */}
            {activeView === 'home' && searchQuery === '' && <SmartPacks />}

            {/* PRODUCT CATALOG GRID HEADER */}
            <div className="flex items-center justify-between mt-6 mb-3 px-1">
              <h3 className="font-sora font-bold text-base text-brand-dark">
                {searchQuery ? `Results for "${searchQuery}"` : 'Popular near you'}
              </h3>
              <span className="text-xs font-semibold text-brand-green">
                Showing {filteredProducts.length} items
              </span>
            </div>

            {/* PRODUCT CATALOG GRID */}
            {filteredProducts.length === 0 ? (
              <div className="bg-white border border-brand-border rounded-2xl p-12 text-center my-4">
                <div className="text-4xl mb-2">🔍</div>
                <h4 className="font-sora font-bold text-sm text-brand-dark">No products found</h4>
                <p className="text-xs text-brand-muted mt-1">
                  Try searching for snacks, maggi, drinks or water.
                </p>
                <button
                  onClick={() => {
                    setSearchQuery('');
                    setSelectedCategory('All');
                  }}
                  className="mt-3 bg-brand-dark text-white font-bold text-xs px-4 py-2 rounded-xl"
                >
                  Clear Filters
                </button>
              </div>
            ) : (
              <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-3.5 sm:gap-4 mb-8">
                {filteredProducts.map((product) => (
                  <ProductCard key={product.id} product={product} />
                ))}
              </div>
            )}
          </main>
        </>
      )}

      {/* FLOATING CART BAR ON MOBILE */}
      {cart.length > 0 && activeView !== 'splash' && (
        <div className="fixed bottom-18 left-4 right-4 md:hidden z-40">
          <button
            onClick={() => setIsCartDrawerOpen(true)}
            className="w-full bg-brand-dark text-white rounded-2xl p-3.5 flex items-center justify-between shadow-cart border border-brand-green/30 active:scale-98 transition-transform"
          >
            <div className="text-xs font-bold font-sora">
              Cart · {totalItemsCount} {totalItemsCount === 1 ? 'item' : 'items'}
            </div>
            <div className="text-xs font-semibold flex items-center gap-1 opacity-95">
              ₹{total} <ArrowRight className="w-4 h-4 text-brand-green" />
            </div>
          </button>
        </div>
      )}

      {/* MODAL & DRAWER COMPONENTS */}
      <ProductDetailModal />
      <CartDrawer />

      {/* MOBILE BOTTOM NAVIGATION */}
      <BottomNav />
    </div>
  );
}

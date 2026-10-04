'use client';

import React from 'react';
import { useCart } from '@/context/CartContext';
import { INITIAL_PRODUCTS, Product } from '@/lib/db';
import { X, Heart, Plus, Minus, Check } from 'lucide-react';

export function ProductDetailModal() {
  const {
    activeProductModal,
    setActiveProductModal,
    cart,
    addToCart,
    updateQuantity,
  } = useCart();
  const [isWishlisted, setIsWishlisted] = React.useState(false);

  if (!activeProductModal) return null;

  const product = activeProductModal;
  const cartItem = cart.find((item) => item.product.id === product.id);
  const quantity = cartItem ? cartItem.quantity : 1;

  // Frequently bought together items (exclude current product)
  const frequentlyBought = INITIAL_PRODUCTS.filter((p) => p.id !== product.id).slice(0, 4);

  return (
    <div className="fixed inset-0 z-50 bg-black/60 backdrop-blur-sm flex items-center justify-center p-3 sm:p-4 overflow-y-auto">
      <div className="bg-white rounded-3xl max-w-lg w-full overflow-hidden shadow-2xl relative animate-in fade-in zoom-in-95 duration-200">
        {/* Top Floating Control Bar */}
        <div className="absolute top-3 left-3 right-3 z-10 flex items-center justify-between">
          <button
            onClick={() => setActiveProductModal(null)}
            className="w-9 h-9 rounded-full bg-white/90 backdrop-blur border border-brand-border flex items-center justify-center text-brand-dark hover:bg-white transition-colors shadow-sm"
          >
            <X className="w-5 h-5" />
          </button>
          <button
            onClick={() => setIsWishlisted(!isWishlisted)}
            className={`w-9 h-9 rounded-full bg-white/90 backdrop-blur border border-brand-border flex items-center justify-center transition-colors shadow-sm ${
              isWishlisted ? 'text-red-500' : 'text-brand-muted hover:text-red-500'
            }`}
          >
            <Heart className={`w-5 h-5 ${isWishlisted ? 'fill-current' : ''}`} />
          </button>
        </div>

        {/* Hero Visual Box */}
        <div
          className="h-56 sm:h-64 flex items-center justify-center text-7xl sm:text-8xl select-none"
          style={{ backgroundColor: product.bgHex }}
        >
          {product.emoji}
        </div>

        {/* Product Info Body */}
        <div className="p-5 max-h-[60vh] overflow-y-auto no-scrollbar">
          <div className="text-xs font-bold text-brand-green uppercase tracking-wider mb-0.5">
            {product.brand}
          </div>
          <h2 className="font-sora font-bold text-xl text-brand-dark mb-2">{product.name}</h2>

          <div className="flex items-baseline gap-2 mb-2">
            <span className="font-sora font-extrabold text-2xl text-brand-dark">
              ₹{product.price}
            </span>
            {product.mrp && (
              <span className="text-sm text-brand-muted line-through font-medium">
                ₹{product.mrp}
              </span>
            )}
            {product.discountBadge && (
              <span className="bg-brand-accent text-white font-bold text-xs px-2 py-0.5 rounded shadow-sm">
                {product.discountBadge}
              </span>
            )}
          </div>

          <div className="text-xs font-bold text-brand-green mb-4 flex items-center gap-1.5">
            <span className="w-2 h-2 rounded-full bg-brand-green inline-block animate-pulse" />
            In stock · {product.stock} packs available at Sri Siva Store
          </div>

          {/* Quantity Selector */}
          <div className="flex items-center gap-4 bg-brand-surface border border-brand-border rounded-xl px-4 py-2.5 w-fit mb-5">
            <span className="text-xs font-bold text-brand-muted uppercase">Quantity:</span>
            <div className="flex items-center gap-3">
              <button
                onClick={() => {
                  if (quantity > 1) {
                    if (cartItem) updateQuantity(product.id, quantity - 1);
                  }
                }}
                className="w-7 h-7 rounded-lg bg-white border border-brand-border flex items-center justify-center font-bold text-brand-dark hover:bg-brand-surface transition-colors"
              >
                <Minus className="w-4 h-4" />
              </button>
              <span className="font-sora font-bold text-sm text-brand-dark min-w-[20px] text-center">
                {quantity}
              </span>
              <button
                onClick={() => {
                  if (cartItem) updateQuantity(product.id, quantity + 1);
                  else addToCart(product, 1);
                }}
                className="w-7 h-7 rounded-lg bg-white border border-brand-border flex items-center justify-center font-bold text-brand-dark hover:bg-brand-surface transition-colors"
              >
                <Plus className="w-4 h-4" />
              </button>
            </div>
          </div>

          {/* Description */}
          <p className="text-xs text-brand-muted leading-relaxed mb-6">{product.description}</p>

          {/* Frequently Bought Together */}
          <div className="border-t border-brand-border pt-4">
            <h3 className="font-sora font-bold text-sm text-brand-dark mb-3">
              Frequently bought together
            </h3>
            <div className="flex gap-3 overflow-x-auto no-scrollbar pb-2">
              {frequentlyBought.map((fItem) => (
                <div
                  key={fItem.id}
                  onClick={() => setActiveProductModal(fItem)}
                  className="flex-shrink-0 w-24 text-center cursor-pointer group"
                >
                  <div
                    className="w-24 h-20 rounded-xl border border-brand-border flex items-center justify-center text-3xl mb-1.5 group-hover:border-brand-green transition-all"
                    style={{ backgroundColor: fItem.bgHex }}
                  >
                    {fItem.emoji}
                  </div>
                  <div className="text-[11px] font-semibold text-brand-text truncate">
                    {fItem.name}
                  </div>
                  <div className="text-[10px] text-brand-muted">₹{fItem.price}</div>
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Bottom CTA Bar */}
        <div className="p-4 bg-white border-t border-brand-border">
          <button
            onClick={() => {
              if (!cartItem) addToCart(product, quantity);
              setActiveProductModal(null);
            }}
            className="w-full bg-brand-dark hover:bg-black text-white font-sora font-bold py-3.5 rounded-2xl text-sm transition-all shadow-lg flex items-center justify-center gap-2"
          >
            <span>{cartItem ? 'Update Cart' : 'Add to cart'}</span>
            <span>·</span>
            <span>₹{product.price * quantity}</span>
          </button>
        </div>
      </div>
    </div>
  );
}

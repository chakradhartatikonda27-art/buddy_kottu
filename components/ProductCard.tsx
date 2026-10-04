'use client';

import React from 'react';
import { Product } from '@/lib/db';
import { useCart } from '@/context/CartContext';
import { Plus, Minus } from 'lucide-react';

interface ProductCardProps {
  product: Product;
}

export function ProductCard({ product }: ProductCardProps) {
  const { cart, addToCart, updateQuantity, setActiveProductModal } = useCart();

  const cartItem = cart.find((item) => item.product.id === product.id);
  const quantity = cartItem ? cartItem.quantity : 0;

  return (
    <div className="bg-white border-1.5 border-brand-border rounded-card overflow-hidden flex flex-col justify-between hover:border-brand-green transition-all shadow-sm group">
      {/* Product Image Box */}
      <div
        onClick={() => setActiveProductModal(product)}
        className="h-28 sm:h-32 flex items-center justify-center cursor-pointer relative select-none group-hover:scale-105 transition-transform overflow-hidden bg-white"
      >
        {product.imageUrl ? (
          <img
            src={product.imageUrl}
            alt={product.name}
            className="w-full h-full object-cover"
          />
        ) : (
          <span className="text-3xl sm:text-4xl">{product.emoji}</span>
        )}
        {product.discountBadge && (
          <span className="absolute top-2 left-2 bg-[#FF5722] text-white font-bold text-[9.5px] px-1.5 py-0.5 rounded shadow-sm z-10">
            {product.discountBadge}
          </span>
        )}
      </div>

      {/* Info Content */}
      <div className="p-2.5 sm:p-3 flex-1 flex flex-col justify-between">
        <div>
          <div className="text-[10px] text-brand-muted font-medium mb-0.5">{product.brand}</div>
          <h4
            onClick={() => setActiveProductModal(product)}
            className="text-xs font-semibold text-brand-text leading-snug mb-1.5 min-h-[32px] cursor-pointer hover:text-brand-green line-clamp-2"
          >
            {product.name}
          </h4>
        </div>

        <div>
          {/* Price Row */}
          <div className="flex items-baseline gap-1.5 mb-2">
            <span className="font-sora font-bold text-sm text-brand-text">₹{product.price}</span>
            {product.mrp && (
              <span className="text-[10.5px] text-brand-muted line-through font-medium">
                ₹{product.mrp}
              </span>
            )}
          </div>

          {/* Stepper or Add Button */}
          {quantity > 0 ? (
            <div className="w-full flex items-center justify-between bg-brand-dark rounded-lg px-2 py-1 text-white">
              <button
                onClick={(e) => {
                  e.stopPropagation();
                  updateQuantity(product.id, quantity - 1);
                }}
                className="hover:bg-white/20 rounded p-0.5 text-xs font-bold transition-colors"
                aria-label="Decrease quantity"
              >
                <Minus className="w-3.5 h-3.5" />
              </button>
              <span className="text-xs font-bold font-sora px-1">{quantity}</span>
              <button
                onClick={(e) => {
                  e.stopPropagation();
                  updateQuantity(product.id, quantity + 1);
                }}
                className="hover:bg-white/20 rounded p-0.5 text-xs font-bold transition-colors"
                aria-label="Increase quantity"
              >
                <Plus className="w-3.5 h-3.5" />
              </button>
            </div>
          ) : (
            <button
              onClick={(e) => {
                e.stopPropagation();
                addToCart(product, 1);
              }}
              className="w-full border-1.5 border-brand-green text-brand-green hover:bg-brand-green hover:text-white rounded-lg py-1.5 text-xs font-bold font-inter transition-all flex items-center justify-center gap-1"
            >
              <Plus className="w-3.5 h-3.5" /> Add
            </button>
          )}
        </div>
      </div>
    </div>
  );
}

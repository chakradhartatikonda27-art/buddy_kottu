'use client';

import React, { useState } from 'react';
import { useCart } from '@/context/CartContext';
import { X, Minus, Plus, ShoppingBag, ArrowRight, Tag, Check, Trash2 } from 'lucide-react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';

export function CartDrawer() {
  const {
    cart,
    updateQuantity,
    removeFromCart,
    subtotal,
    deliveryFee,
    couponCode,
    appliedDiscount,
    applyCoupon,
    removeCoupon,
    total,
    isCartDrawerOpen,
    setIsCartDrawerOpen,
    setActiveView,
  } = useCart();

  const [inputCoupon, setInputCoupon] = useState('');
  const [couponMessage, setCouponMessage] = useState<{ success?: boolean; text?: string }>({});
  const router = useRouter();

  if (!isCartDrawerOpen) return null;

  const handleApplyCoupon = (e: React.FormEvent) => {
    e.preventDefault();
    if (!inputCoupon.trim()) return;
    const res = applyCoupon(inputCoupon);
    setCouponMessage({ success: res.success, text: res.message });
    if (res.success) setInputCoupon('');
  };

  const handleProceedToCheckout = () => {
    setIsCartDrawerOpen(false);
    setActiveView('checkout');
    router.push('/checkout');
  };

  return (
    <div className="fixed inset-0 z-50 bg-black/60 backdrop-blur-sm flex justify-end">
      <div className="w-full max-w-md bg-white h-full flex flex-col shadow-2xl animate-in slide-in-from-right duration-250">
        {/* Drawer Header */}
        <div className="px-5 py-4 border-b border-brand-border flex items-center justify-between bg-white">
          <div className="flex items-center gap-2">
            <ShoppingBag className="w-5 h-5 text-brand-green" />
            <h2 className="font-sora font-bold text-lg text-brand-dark">Your Cart</h2>
            <span className="bg-brand-surface text-brand-muted text-xs font-bold px-2 py-0.5 rounded-full">
              {cart.reduce((a, b) => a + b.quantity, 0)} items
            </span>
          </div>
          <button
            onClick={() => setIsCartDrawerOpen(false)}
            className="w-8 h-8 rounded-full bg-brand-surface border border-brand-border flex items-center justify-center text-brand-muted hover:text-brand-dark transition-colors"
          >
            <X className="w-4 h-4" />
          </button>
        </div>

        {/* Drawer Scrollable Content */}
        <div className="flex-1 overflow-y-auto p-5 space-y-4">
          {cart.length === 0 ? (
            <div className="text-center py-16">
              <div className="text-6xl mb-3">🛒</div>
              <h3 className="font-sora font-bold text-base text-brand-dark mb-1">
                Your cart is empty
              </h3>
              <p className="text-xs text-brand-muted mb-4">
                Looks like you haven&apos;t added anything to your cart yet.
              </p>
              <button
                onClick={() => setIsCartDrawerOpen(false)}
                className="bg-brand-dark text-white font-bold text-xs px-5 py-2.5 rounded-xl hover:bg-black transition-colors"
              >
                Browse Store Products
              </button>
            </div>
          ) : (
            <>
              {/* Cart Items List */}
              <div className="space-y-3">
                {cart.map(({ product, quantity }) => (
                  <div
                    key={product.id}
                    className="flex items-center gap-3 p-3 bg-white border border-brand-border rounded-xl shadow-2xs hover:border-brand-green transition-colors"
                  >
                    <div
                      className="w-12 h-12 rounded-xl flex items-center justify-center text-2xl flex-shrink-0"
                      style={{ backgroundColor: product.bgHex }}
                    >
                      {product.emoji}
                    </div>

                    <div className="flex-1 min-w-0">
                      <h4 className="text-xs font-semibold text-brand-text truncate">
                        {product.name}
                      </h4>
                      <p className="text-[11px] text-brand-muted font-medium">
                        ₹{product.price} × {quantity}
                      </p>
                    </div>

                    {/* Stepper */}
                    <div className="flex items-center gap-2 bg-brand-surface border border-brand-border rounded-lg p-1">
                      <button
                        onClick={() => updateQuantity(product.id, quantity - 1)}
                        className="text-brand-dark hover:bg-white rounded p-1 transition-colors"
                      >
                        <Minus className="w-3 h-3" />
                      </button>
                      <span className="text-xs font-bold text-brand-dark min-w-[14px] text-center">
                        {quantity}
                      </span>
                      <button
                        onClick={() => updateQuantity(product.id, quantity + 1)}
                        className="text-brand-dark hover:bg-white rounded p-1 transition-colors"
                      >
                        <Plus className="w-3 h-3" />
                      </button>
                    </div>

                    <button
                      onClick={() => removeFromCart(product.id)}
                      className="text-brand-muted hover:text-red-500 p-1 transition-colors"
                      aria-label="Remove item"
                    >
                      <Trash2 className="w-3.5 h-3.5" />
                    </button>
                  </div>
                ))}
              </div>

              {/* Coupon Code Section */}
              <div className="bg-brand-surface border border-brand-border rounded-2xl p-3.5">
                <div className="flex items-center gap-1.5 text-xs font-bold text-brand-dark mb-2">
                  <Tag className="w-4 h-4 text-brand-green" />
                  <span>Apply Coupon Code</span>
                </div>

                {couponCode ? (
                  <div className="flex items-center justify-between bg-white border border-brand-green rounded-xl px-3 py-2 text-xs">
                    <div className="flex items-center gap-2">
                      <span className="font-bold text-brand-green">🏷️ {couponCode}</span>
                      <span className="text-[11px] text-brand-muted">
                        (-₹{appliedDiscount} discount)
                      </span>
                    </div>
                    <button
                      onClick={removeCoupon}
                      className="text-brand-muted hover:text-red-500 font-bold text-xs"
                    >
                      Remove
                    </button>
                  </div>
                ) : (
                  <form onSubmit={handleApplyCoupon} className="flex gap-2">
                    <input
                      type="text"
                      value={inputCoupon}
                      onChange={(e) => setInputCoupon(e.target.value)}
                      placeholder="Try FIRST10 or FLAT50"
                      className="flex-1 bg-white border border-brand-border rounded-xl px-3 py-2 text-xs font-medium outline-none focus:border-brand-green uppercase"
                    />
                    <button
                      type="submit"
                      className="bg-brand-dark text-white font-bold text-xs px-4 py-2 rounded-xl hover:bg-black transition-colors"
                    >
                      Apply
                    </button>
                  </form>
                )}

                {couponMessage.text && (
                  <p
                    className={`text-[11px] font-medium mt-2 ${
                      couponMessage.success ? 'text-brand-green' : 'text-red-600'
                    }`}
                  >
                    {couponMessage.text}
                  </p>
                )}
              </div>

              {/* Bill Details Summary */}
              <div className="bg-white border border-brand-border rounded-card p-4 space-y-2.5">
                <h3 className="font-sora font-bold text-xs text-brand-dark uppercase tracking-wider mb-2">
                  Bill Details
                </h3>

                <div className="flex justify-between text-xs text-brand-muted">
                  <span>Item Subtotal</span>
                  <span className="font-medium text-brand-text">₹{subtotal}</span>
                </div>

                <div className="flex justify-between text-xs text-brand-muted">
                  <span>Delivery Fee</span>
                  <span className="font-medium text-brand-text">
                    {deliveryFee === 0 ? (
                      <span className="text-brand-green font-bold">FREE (Above ₹199)</span>
                    ) : (
                      `₹${deliveryFee}`
                    )}
                  </span>
                </div>

                {appliedDiscount > 0 && (
                  <div className="flex justify-between text-xs text-brand-green font-semibold">
                    <span>Coupon ({couponCode})</span>
                    <span>−₹{appliedDiscount}</span>
                  </div>
                )}

                <div className="border-t border-dashed border-brand-border pt-2.5 flex justify-between font-sora font-bold text-sm text-brand-dark">
                  <span>To Pay</span>
                  <span className="text-base text-brand-green">₹{total}</span>
                </div>
              </div>
            </>
          )}
        </div>

        {/* Drawer Footer CTA */}
        {cart.length > 0 && (
          <div className="p-4 bg-white border-t border-brand-border">
            <button
              onClick={handleProceedToCheckout}
              className="w-full bg-brand-accent hover:bg-orange-600 text-white font-sora font-bold py-3.5 px-5 rounded-2xl text-sm transition-all shadow-lg flex items-center justify-between"
            >
              <span>Proceed to Checkout</span>
              <span className="flex items-center gap-1">
                ₹{total} <ArrowRight className="w-4 h-4" />
              </span>
            </button>
          </div>
        )}
      </div>
    </div>
  );
}

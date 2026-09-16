'use client';

import React, { useState } from 'react';
import { useCart } from '@/context/CartContext';
import { ArrowLeft, MapPin, Smartphone, Banknote, ShieldCheck } from 'lucide-react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';

export default function CheckoutPage() {
  const {
    cart,
    subtotal,
    deliveryFee,
    appliedDiscount,
    couponCode,
    total,
    selectedAddress,
    setSelectedAddress,
    selectedPayment,
    setSelectedPayment,
    clearCart,
    setActiveOrderId,
    setActiveView,
  } = useCart();

  const [isSubmitting, setIsSubmitting] = useState(false);
  const router = useRouter();

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

  const paymentMethods = [
    { id: 'upi-gpay', name: 'UPI — Google Pay', icon: '📱' },
    { id: 'upi-phonepe', name: 'PhonePe', icon: '📱' },
    { id: 'cod', name: 'Cash on delivery', icon: '💵' },
  ];

  const handlePlaceOrder = async () => {
    if (cart.length === 0) return;
    setIsSubmitting(true);

    try {
      const orderData = {
        items: cart.map((i) => ({
          productId: i.product.id,
          name: i.product.name,
          price: i.product.price,
          quantity: i.quantity,
          emoji: i.product.emoji,
        })),
        subtotal,
        deliveryFee,
        discount: appliedDiscount,
        couponCode,
        total,
        address: selectedAddress,
        paymentMethod: selectedPayment,
      };

      const res = await fetch('/api/orders', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(orderData),
      });

      const data = await res.json();
      if (data.success && data.order) {
        clearCart();
        setActiveOrderId(data.order.id);
        setActiveView('tracking');
        router.push(`/tracking/${data.order.id}`);
      } else {
        alert('Failed to place order. Please try again.');
      }
    } catch (err) {
      console.error(err);
      alert('Network error. Please try again.');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#EEF0EC] pb-24">
      {/* Top Header */}
      <div className="bg-white border-b border-brand-border px-4 py-3 sticky top-0 z-40">
        <div className="max-w-md mx-auto flex items-center gap-3">
          <Link
            href="/"
            onClick={() => setActiveView('home')}
            className="w-8 h-8 rounded-full bg-brand-surface flex items-center justify-center text-brand-dark hover:bg-brand-border transition-colors"
          >
            <ArrowLeft className="w-4 h-4" />
          </Link>
          <h1 className="font-sora font-bold text-base text-brand-dark">Checkout</h1>
        </div>
      </div>

      <div className="max-w-md mx-auto p-4 space-y-4">
        {/* Delivery Address Section */}
        <div>
          <div className="text-xs font-bold text-brand-muted uppercase tracking-wider mb-2 px-1">
            Deliver to
          </div>

          {/* Address Chips */}
          <div className="flex gap-2 overflow-x-auto no-scrollbar mb-2">
            {addresses.map((addr) => (
              <button
                key={addr.id}
                onClick={() => setSelectedAddress(addr)}
                className={`flex-shrink-0 px-3 py-1.5 rounded-full text-xs font-semibold border transition-all ${
                  selectedAddress.id === addr.id
                    ? 'bg-white text-brand-green border-brand-green shadow-xs'
                    : 'bg-white text-brand-muted border-brand-border'
                }`}
              >
                📍 {addr.label}
              </button>
            ))}
          </div>

          {/* Active Address Card */}
          <div className="bg-white border-1.5 border-brand-green rounded-2xl p-3.5 flex gap-3 items-start shadow-xs">
            <MapPin className="w-5 h-5 text-brand-green flex-shrink-0 mt-0.5" />
            <div>
              <div className="font-sora font-bold text-xs text-brand-dark mb-0.5">
                {selectedAddress.line1}
              </div>
              <div className="text-[11.5px] text-brand-muted">{selectedAddress.landmark}</div>
            </div>
          </div>
        </div>

        {/* Payment Method Section */}
        <div>
          <div className="text-xs font-bold text-brand-muted uppercase tracking-wider mb-2 px-1">
            Payment method
          </div>

          <div className="space-y-2">
            {paymentMethods.map((pm) => {
              const isSelected = selectedPayment === pm.name;
              return (
                <div
                  key={pm.id}
                  onClick={() => setSelectedPayment(pm.name)}
                  className={`bg-white border-1.5 rounded-2xl p-3.5 flex items-center gap-3 cursor-pointer transition-all ${
                    isSelected ? 'border-brand-green shadow-xs' : 'border-brand-border'
                  }`}
                >
                  {/* Radio dot */}
                  <div
                    className={`w-4 h-4 rounded-full border-2 flex items-center justify-center ${
                      isSelected ? 'border-brand-green' : 'border-brand-border'
                    }`}
                  >
                    {isSelected && <div className="w-2 h-2 rounded-full bg-brand-green" />}
                  </div>

                  <span className="font-semibold text-xs text-brand-dark flex-1">{pm.name}</span>
                  <span className="text-base">{pm.icon}</span>
                </div>
              );
            })}
          </div>
        </div>

        {/* Bill Summary */}
        <div className="bg-white border border-brand-border rounded-card p-4 space-y-2.5">
          <div className="flex justify-between text-xs text-brand-muted">
            <span>Items ({cart.reduce((a, b) => a + b.quantity, 0)})</span>
            <span className="font-medium text-brand-text">₹{subtotal}</span>
          </div>
          <div className="flex justify-between text-xs text-brand-muted">
            <span>Delivery Fee</span>
            <span className="font-medium text-brand-text">
              {deliveryFee === 0 ? <span className="text-brand-green font-bold">FREE</span> : `₹${deliveryFee}`}
            </span>
          </div>
          {appliedDiscount > 0 && (
            <div className="flex justify-between text-xs text-brand-green font-semibold">
              <span>Coupon ({couponCode})</span>
              <span>−₹{appliedDiscount}</span>
            </div>
          )}
          <div className="border-t border-dashed border-brand-border pt-2 flex justify-between font-sora font-bold text-sm text-brand-dark">
            <span>Total Amount</span>
            <span className="text-base text-brand-green">₹{total}</span>
          </div>
        </div>

        <div className="flex items-center justify-center gap-1.5 text-[11px] text-brand-muted font-medium py-1">
          <ShieldCheck className="w-4 h-4 text-brand-green" />
          <span>100% Safe & Secure Order · Sri Siva Store Guarantee</span>
        </div>
      </div>

      {/* Bottom Place Order CTA */}
      <div className="fixed bottom-0 left-0 right-0 p-4 bg-white border-t border-brand-border z-40">
        <div className="max-w-md mx-auto">
          <button
            onClick={handlePlaceOrder}
            disabled={isSubmitting || cart.length === 0}
            className="w-full bg-brand-accent hover:bg-orange-600 disabled:opacity-50 text-white font-sora font-bold py-4 px-6 rounded-2xl text-sm transition-all shadow-lg flex items-center justify-between"
          >
            <span>{isSubmitting ? 'Placing Order...' : 'Place order'}</span>
            <span>₹{total} →</span>
          </button>
        </div>
      </div>
    </div>
  );
}

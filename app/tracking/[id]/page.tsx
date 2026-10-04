'use client';

import React, { useState, useEffect, use } from 'react';
import { ArrowLeft, Check, Clock, MessageSquare, Play } from 'lucide-react';
import { useCart } from '@/context/CartContext';
import { Order, OrderStatus } from '@/lib/db';
import Link from 'next/link';

export default function OrderTrackingPage({
  params,
}: {
  params: Promise<{ id: string }> | { id: string };
}) {
  const resolvedParams = params instanceof Promise ? use(params) : params;
  const orderId = resolvedParams.id;

  const { setActiveView } = useCart();
  const [order, setOrder] = useState<Order | null>(null);
  const [loading, setLoading] = useState(true);

  const fetchOrder = async () => {
    try {
      const res = await fetch(`/api/orders/${orderId}`);
      const data = await res.json();
      if (data.success && data.order) {
        setOrder(data.order);
      }
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchOrder();
    const interval = setInterval(fetchOrder, 4000);
    return () => clearInterval(interval);
  }, [orderId]);

  const handleAdvanceStatus = async (nextStatus: OrderStatus) => {
    try {
      const res = await fetch(`/api/orders/${orderId}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ status: nextStatus }),
      });
      const data = await res.json();
      if (data.success && data.order) {
        setOrder(data.order);
      }
    } catch (err) {
      console.error(err);
    }
  };

  const steps: { key: OrderStatus; title: string; subtitle: string }[] = [
    { key: 'received', title: 'Order received', subtitle: '6:02 PM' },
    { key: 'accepted', title: 'Accepted by store', subtitle: '6:03 PM' },
    { key: 'preparing', title: 'Preparing your order', subtitle: 'In progress' },
    { key: 'out_for_delivery', title: 'Out for delivery', subtitle: 'Delivery executive assigned' },
    { key: 'delivered', title: 'Delivered', subtitle: 'Handed over successfully' },
  ];

  const getStepState = (stepKey: OrderStatus, currentStatus: OrderStatus) => {
    const statusOrder: OrderStatus[] = [
      'received',
      'accepted',
      'preparing',
      'out_for_delivery',
      'delivered',
    ];
    const stepIdx = statusOrder.indexOf(stepKey);
    const currIdx = statusOrder.indexOf(currentStatus);

    if (stepIdx < currIdx) return 'done';
    if (stepIdx === currIdx) return 'current';
    return 'pending';
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-[#EEF0EC] flex items-center justify-center p-4">
        <div className="font-sora font-bold text-sm text-brand-dark animate-pulse">
          Loading order status...
        </div>
      </div>
    );
  }

  if (!order) {
    return (
      <div className="min-h-screen bg-[#EEF0EC] p-4 text-center py-20">
        <h2 className="font-sora font-bold text-lg text-brand-dark mb-2">Order Not Found</h2>
        <p className="text-xs text-brand-muted mb-4">Order #{orderId} could not be located.</p>
        <Link href="/" className="bg-brand-dark text-white text-xs font-bold px-4 py-2 rounded-xl">
          Return to Store
        </Link>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#EEF0EC] pb-20">
      {/* Header */}
      <div className="bg-white border-b border-brand-border px-4 py-3 sticky top-0 z-40">
        <div className="max-w-md mx-auto flex items-center gap-3">
          <Link
            href="/"
            onClick={() => setActiveView('home')}
            className="w-8 h-8 rounded-full bg-brand-surface flex items-center justify-center text-brand-dark hover:bg-brand-border transition-colors"
          >
            <ArrowLeft className="w-4 h-4" />
          </Link>
          <h1 className="font-sora font-bold text-base text-brand-dark">Order status</h1>
        </div>
      </div>

      <div className="max-w-md mx-auto">
        {/* Order Details Top Card */}
        <div className="bg-white border-b border-brand-border p-4">
          <div className="text-[11.5px] text-brand-muted mb-1 font-medium">
            Order {order.id} · {order.items.length} items · ₹{order.total}
          </div>
          <div className="font-sora text-base font-bold text-brand-dark flex items-center gap-2">
            <Clock className="w-4 h-4 text-brand-green" />
            <span>
              {order.status === 'delivered'
                ? 'Order Delivered!'
                : `Arriving in ${order.etaMinutes} minutes`}
            </span>
          </div>
        </div>

        {/* Status Timeline */}
        <div className="p-5">
          <div className="space-y-6 relative">
            {steps.map((step, idx) => {
              const state = getStepState(step.key, order.status);
              const isLast = idx === steps.length - 1;

              return (
                <div key={step.key} className="flex gap-4 relative">
                  {/* Connecting Line */}
                  {!isLast && (
                    <div
                      className={`absolute left-[11.5px] top-6 bottom--6 w-0.5 z-0 ${
                        state === 'done' ? 'bg-brand-green' : 'bg-brand-border'
                      }`}
                      style={{ height: 'calc(100% + 12px)' }}
                    />
                  )}

                  {/* Dot Icon */}
                  <div
                    className={`w-6 h-6 rounded-full flex items-center justify-center text-xs font-bold text-white z-10 flex-shrink-0 transition-colors ${
                      state === 'done'
                        ? 'bg-brand-green'
                        : state === 'current'
                        ? 'bg-brand-accent animate-bounce'
                        : 'bg-brand-border'
                    }`}
                  >
                    {state === 'done' ? <Check className="w-3.5 h-3.5" /> : state === 'current' ? '●' : ''}
                  </div>

                  {/* Step Text */}
                  <div>
                    <div
                      className={`text-xs font-bold ${
                        state === 'pending' ? 'text-brand-muted font-normal' : 'text-brand-dark'
                      }`}
                    >
                      {step.title}
                    </div>
                    <div className="text-[10.5px] text-brand-muted font-medium">{step.subtitle}</div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>

        {/* Live Simulator Box for Demo Testing */}
        <div className="mx-4 my-2 p-3 bg-white border border-brand-border rounded-2xl shadow-2xs">
          <div className="flex items-center gap-1.5 text-xs font-bold text-brand-dark mb-2">
            <Play className="w-3.5 h-3.5 text-brand-green" />
            <span>Demo Live Simulator (Advance Order Status)</span>
          </div>
          <div className="grid grid-cols-3 gap-1.5 text-[10px] font-bold">
            <button
              onClick={() => handleAdvanceStatus('accepted')}
              className="bg-brand-surface hover:bg-brand-green hover:text-white p-1.5 rounded-lg border border-brand-border transition-colors text-center"
            >
              1. Accept
            </button>
            <button
              onClick={() => handleAdvanceStatus('preparing')}
              className="bg-brand-surface hover:bg-brand-green hover:text-white p-1.5 rounded-lg border border-brand-border transition-colors text-center"
            >
              2. Prepare
            </button>
            <button
              onClick={() => handleAdvanceStatus('out_for_delivery')}
              className="bg-brand-surface hover:bg-brand-green hover:text-white p-1.5 rounded-lg border border-brand-border transition-colors text-center"
            >
              3. Dispatch
            </button>
            <button
              onClick={() => handleAdvanceStatus('delivered')}
              className="col-span-3 bg-brand-dark text-white p-1.5 rounded-lg transition-colors text-center mt-0.5"
            >
              4. Mark Delivered
            </button>
          </div>
        </div>

        {/* Item Summary Card */}
        <div className="mx-4 my-3 bg-white border border-brand-border rounded-2xl p-4">
          <div className="text-xs font-bold text-brand-dark mb-2">Order Summary</div>
          <div className="space-y-2 mb-3">
            {order.items.map((item, i) => (
              <div key={i} className="flex justify-between text-xs text-brand-text">
                <span>
                  {item.emoji} {item.name} × {item.quantity}
                </span>
                <span className="font-semibold">₹{item.price * item.quantity}</span>
              </div>
            ))}
          </div>
          <div className="border-t border-brand-border pt-2 flex justify-between text-xs font-bold text-brand-dark">
            <span>Total Paid ({order.paymentMethod})</span>
            <span className="text-brand-green">₹{order.total}</span>
          </div>
        </div>

        {/* WhatsApp Support CTA */}
        <div className="px-4">
          <a
            href="https://wa.me/919876543210?text=Hi%20Sri%20Siva%20Store%2C%20need%20help%20with%20my%20order"
            target="_blank"
            rel="noopener noreferrer"
            className="block border-1.5 border-brand-border bg-white rounded-2xl p-3.5 text-center text-xs font-bold text-brand-dark hover:border-brand-green transition-colors shadow-2xs"
          >
            <div className="flex items-center justify-center gap-2">
              <MessageSquare className="w-4 h-4 text-brand-green" />
              <span>Need help with this order? Chat on WhatsApp</span>
            </div>
          </a>
        </div>
      </div>
    </div>
  );
}

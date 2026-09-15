'use client';

import React, { useState } from 'react';

interface OrderItem {
  id: string;
  orderNumber: string;
  customerName: string;
  phone: string;
  location: string;
  items: string;
  total: number;
  payment: string;
  status: 'NEW' | 'ACCEPTED' | 'PREPARING' | 'OUT_FOR_DELIVERY' | 'DELIVERED';
  time: string;
}

const initialOrders: OrderItem[] = [
  {
    id: 'ord_101',
    orderNumber: 'BK2026091501',
    customerName: 'Rahul V',
    phone: '9876543210',
    location: 'Hostel Block B, Room 304',
    items: 'Maggi x 2, Coke 750ml x 1',
    total: 118,
    payment: 'UPI — PAID',
    status: 'NEW',
    time: '2 mins ago',
  },
  {
    id: 'ord_102',
    orderNumber: 'BK2026091502',
    customerName: 'Dr. Srinivas',
    phone: '9848022338',
    location: 'GSL Hospital OPD 2nd Floor',
    items: 'Kinley Water 1L x 3, Real Juice x 1',
    total: 170,
    payment: 'UPI — PAID',
    status: 'NEW',
    time: '5 mins ago',
  },
  {
    id: 'ord_103',
    orderNumber: 'BK2026091503',
    customerName: 'Anitha K',
    phone: '9123456789',
    location: 'GSL Staff Quarters Q-12',
    items: 'Amul Milk x 2, Bread x 1',
    total: 104,
    payment: 'COD — PENDING',
    status: 'ACCEPTED',
    time: '8 mins ago',
  },
  {
    id: 'ord_104',
    orderNumber: 'BK2026091504',
    customerName: 'Kalyan M',
    phone: '9988776655',
    location: 'Hostel Block A, Room 102',
    items: 'Hostel Night Pack x 1',
    total: 139,
    payment: 'UPI — PAID',
    status: 'PREPARING',
    time: '12 mins ago',
  },
  {
    id: 'ord_105',
    orderNumber: 'BK2026091505',
    customerName: 'Suresh P',
    phone: '9700112233',
    location: 'University Girls Hostel Gate',
    items: 'Lays Chips x 2, Dairy Milk Silk x 1',
    total: 115,
    payment: 'UPI — PAID',
    status: 'OUT_FOR_DELIVERY',
    time: '15 mins ago',
  },
];

export default function DashboardPage() {
  const [orders, setOrders] = useState<OrderItem[]>(initialOrders);

  const moveOrderStatus = (orderId: string, nextStatus: OrderItem['status']) => {
    setOrders((prev) =>
      prev.map((o) => (o.id === orderId ? { ...o, status: nextStatus } : o))
    );
  };

  const getStatusBg = (status: OrderItem['status']) => {
    switch (status) {
      case 'NEW': return 'bg-amber-500 text-white';
      case 'ACCEPTED': return 'bg-blue-600 text-white';
      case 'PREPARING': return 'bg-purple-600 text-white';
      case 'OUT_FOR_DELIVERY': return 'bg-indigo-600 text-white';
      case 'DELIVERED': return 'bg-emerald-600 text-white';
    }
  };

  return (
    <div className="space-y-8">
      {/* Top Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-extrabold text-slate-900">
            Store Command Center
          </h1>
          <p className="text-sm text-slate-500 font-medium">
            Sri Siva General Stores • Hyperlocal Delivery Desk
          </p>
        </div>
        <div className="flex items-center gap-3">
          <span className="px-3 py-1 bg-emerald-100 text-emerald-800 text-xs font-bold rounded-full">
            ● LIVE FIRESTORE SYNC
          </span>
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-6 gap-4">
        <div className="bg-white p-5 rounded-xl border border-slate-200 shadow-sm">
          <p className="text-xs font-bold text-slate-500 uppercase">Today's Revenue</p>
          <p className="text-2xl font-extrabold text-slate-900 mt-1">₹14,280</p>
          <p className="text-xs text-emerald-600 font-bold mt-1">↑ +18% vs yesterday</p>
        </div>
        <div className="bg-white p-5 rounded-xl border border-slate-200 shadow-sm">
          <p className="text-xs font-bold text-slate-500 uppercase">Today's Orders</p>
          <p className="text-2xl font-extrabold text-slate-900 mt-1">84</p>
          <p className="text-xs text-slate-500 mt-1">Target: 100 orders</p>
        </div>
        <div className="bg-white p-5 rounded-xl border border-amber-300 bg-amber-50/30 shadow-sm">
          <p className="text-xs font-bold text-amber-700 uppercase">Pending Orders</p>
          <p className="text-2xl font-extrabold text-amber-700 mt-1">
            {orders.filter((o) => o.status !== 'DELIVERED').length}
          </p>
          <p className="text-xs text-amber-700 font-medium mt-1">Needs action</p>
        </div>
        <div className="bg-white p-5 rounded-xl border border-slate-200 shadow-sm">
          <p className="text-xs font-bold text-slate-500 uppercase">Avg Order Value</p>
          <p className="text-2xl font-extrabold text-slate-900 mt-1">₹170</p>
          <p className="text-xs text-slate-500 mt-1">High reorder rate</p>
        </div>
        <div className="bg-white p-5 rounded-xl border border-slate-200 shadow-sm">
          <p className="text-xs font-bold text-slate-500 uppercase">Delivered Orders</p>
          <p className="text-2xl font-extrabold text-emerald-600 mt-1">79</p>
          <p className="text-xs text-emerald-600 font-semibold mt-1">94% on-time</p>
        </div>
        <div className="bg-white p-5 rounded-xl border border-rose-200 bg-rose-50/20 shadow-sm">
          <p className="text-xs font-bold text-rose-600 uppercase">Low Stock Alerts</p>
          <p className="text-2xl font-extrabold text-rose-600 mt-1">3 Items</p>
          <p className="text-xs text-rose-600 mt-1">Top Ramen, Soap</p>
        </div>
      </div>

      {/* Order Kanban Board Section */}
      <div>
        <h2 className="text-lg font-bold text-slate-900 mb-4">
          Realtime Order Kanban Workflow
        </h2>

        <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
          {/* Column 1: NEW */}
          <div className="bg-slate-100 p-4 rounded-xl border border-slate-200 min-h-[400px]">
            <div className="flex items-center justify-between mb-3">
              <h3 className="font-extrabold text-sm text-amber-700 flex items-center gap-2">
                <span>🔔 NEW ORDERS</span>
                <span className="bg-amber-200 text-amber-900 px-2 py-0.5 rounded-full text-xs">
                  {orders.filter((o) => o.status === 'NEW').length}
                </span>
              </h3>
            </div>
            <div className="space-y-3">
              {orders
                .filter((o) => o.status === 'NEW')
                .map((order) => (
                  <div key={order.id} className="bg-white p-4 rounded-lg border border-amber-300 shadow-sm space-y-2">
                    <div className="flex justify-between items-start">
                      <div>
                        <span className="font-extrabold text-slate-900 text-sm">{order.orderNumber}</span>
                        <p className="text-xs text-slate-500 font-semibold">{order.customerName} ({order.phone})</p>
                      </div>
                      <span className="text-[10px] bg-amber-100 text-amber-800 font-bold px-2 py-0.5 rounded">
                        {order.time}
                      </span>
                    </div>
                    <p className="text-xs text-slate-700 font-medium">📍 {order.location}</p>
                    <p className="text-xs font-bold text-slate-800 bg-slate-50 p-2 rounded border border-slate-100">
                      {order.items}
                    </p>
                    <div className="flex justify-between items-center pt-1">
                      <span className="text-xs font-extrabold text-emerald-600">₹{order.total} • {order.payment}</span>
                      <button
                        onClick={() => moveOrderStatus(order.id, 'ACCEPTED')}
                        className="px-3 py-1 bg-emerald-600 text-white text-xs font-bold rounded hover:bg-emerald-700"
                      >
                        ACCEPT →
                      </button>
                    </div>
                  </div>
                ))}
            </div>
          </div>

          {/* Column 2: ACCEPTED */}
          <div className="bg-slate-100 p-4 rounded-xl border border-slate-200 min-h-[400px]">
            <div className="flex items-center justify-between mb-3">
              <h3 className="font-extrabold text-sm text-blue-700 flex items-center gap-2">
                <span>👍 ACCEPTED</span>
                <span className="bg-blue-200 text-blue-900 px-2 py-0.5 rounded-full text-xs">
                  {orders.filter((o) => o.status === 'ACCEPTED').length}
                </span>
              </h3>
            </div>
            <div className="space-y-3">
              {orders
                .filter((o) => o.status === 'ACCEPTED')
                .map((order) => (
                  <div key={order.id} className="bg-white p-4 rounded-lg border border-blue-200 shadow-sm space-y-2">
                    <div className="flex justify-between items-start">
                      <div>
                        <span className="font-extrabold text-slate-900 text-sm">{order.orderNumber}</span>
                        <p className="text-xs text-slate-500 font-semibold">{order.customerName}</p>
                      </div>
                    </div>
                    <p className="text-xs text-slate-700 font-medium">📍 {order.location}</p>
                    <p className="text-xs font-bold text-slate-800 bg-slate-50 p-2 rounded">{order.items}</p>
                    <button
                      onClick={() => moveOrderStatus(order.id, 'PREPARING')}
                      className="w-full py-1.5 bg-blue-600 text-white text-xs font-bold rounded hover:bg-blue-700"
                    >
                      START PACKING →
                    </button>
                  </div>
                ))}
            </div>
          </div>

          {/* Column 3: PREPARING */}
          <div className="bg-slate-100 p-4 rounded-xl border border-slate-200 min-h-[400px]">
            <div className="flex items-center justify-between mb-3">
              <h3 className="font-extrabold text-sm text-purple-700 flex items-center gap-2">
                <span>📦 PACKING ITEMS</span>
                <span className="bg-purple-200 text-purple-900 px-2 py-0.5 rounded-full text-xs">
                  {orders.filter((o) => o.status === 'PREPARING').length}
                </span>
              </h3>
            </div>
            <div className="space-y-3">
              {orders
                .filter((o) => o.status === 'PREPARING')
                .map((order) => (
                  <div key={order.id} className="bg-white p-4 rounded-lg border border-purple-200 shadow-sm space-y-2">
                    <div className="flex justify-between items-start">
                      <span className="font-extrabold text-slate-900 text-sm">{order.orderNumber}</span>
                    </div>
                    <p className="text-xs text-slate-700 font-medium">📍 {order.location}</p>
                    <p className="text-xs font-bold text-slate-800 bg-slate-50 p-2 rounded">{order.items}</p>
                    <button
                      onClick={() => moveOrderStatus(order.id, 'OUT_FOR_DELIVERY')}
                      className="w-full py-1.5 bg-purple-600 text-white text-xs font-bold rounded hover:bg-purple-700"
                    >
                      DISPATCH DELIVERY 🛵
                    </button>
                  </div>
                ))}
            </div>
          </div>

          {/* Column 4: OUT FOR DELIVERY */}
          <div className="bg-slate-100 p-4 rounded-xl border border-slate-200 min-h-[400px]">
            <div className="flex items-center justify-between mb-3">
              <h3 className="font-extrabold text-sm text-indigo-700 flex items-center gap-2">
                <span>🛵 OUT FOR DELIVERY</span>
                <span className="bg-indigo-200 text-indigo-900 px-2 py-0.5 rounded-full text-xs">
                  {orders.filter((o) => o.status === 'OUT_FOR_DELIVERY').length}
                </span>
              </h3>
            </div>
            <div className="space-y-3">
              {orders
                .filter((o) => o.status === 'OUT_FOR_DELIVERY')
                .map((order) => (
                  <div key={order.id} className="bg-white p-4 rounded-lg border border-indigo-200 shadow-sm space-y-2">
                    <div className="flex justify-between items-start">
                      <span className="font-extrabold text-slate-900 text-sm">{order.orderNumber}</span>
                    </div>
                    <p className="text-xs text-slate-700 font-medium">📍 {order.location}</p>
                    <button
                      onClick={() => moveOrderStatus(order.id, 'DELIVERED')}
                      className="w-full py-1.5 bg-emerald-600 text-white text-xs font-bold rounded hover:bg-emerald-700"
                    >
                      MARK DELIVERED ✓
                    </button>
                  </div>
                ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

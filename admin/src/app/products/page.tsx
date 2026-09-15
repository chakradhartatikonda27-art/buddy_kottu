'use client';

import React, { useState } from 'react';

interface Product {
  id: string;
  name: string;
  brand: string;
  category: string;
  price: number;
  mrp: number;
  stock: number;
  isAvailable: bool;
}

const initialCatalog: Product[] = [
  { id: 'p1', name: 'Maggi 2-Minute Masala Noodles 70g', brand: 'Nestle', category: 'Instant Food', price: 14, mrp: 15, stock: 120, isAvailable: true },
  { id: 'p4', name: 'Coca-Cola Soft Drink 750ml', brand: 'Coca-Cola', category: 'Cool Drinks & Water', price: 40, mrp: 45, stock: 60, isAvailable: true },
  { id: 'p5', name: 'Thums Up Charged 750ml', brand: 'Thums Up', category: 'Cool Drinks & Water', price: 40, mrp: 45, stock: 90, isAvailable: true },
  { id: 'p6', name: 'Kinley Packaged Water 1L', brand: 'Kinley', category: 'Cool Drinks & Water', price: 20, mrp: 20, stock: 200, isAvailable: true },
  { id: 'p8', name: 'Parle-G Gold Biscuits 250g', brand: 'Parle', category: 'Biscuits & Bakery', price: 28, mrp: 30, stock: 150, isAvailable: true },
  { id: 'p9', name: 'Lays Magic Masala Chips 50g', brand: 'Lays', category: 'Chips & Snacks', price: 20, mrp: 20, stock: 100, isAvailable: true },
];

export default function ProductsPage() {
  const [products, setProducts] = useState<Product[]>(initialCatalog);
  const [editingStockId, setEditingStockId] = useState<string | null>(null);
  const [newStockValue, setNewStockValue] = useState<number>(0);

  const toggleAvailability = (id: string) => {
    setProducts((prev) =>
      prev.map((p) => (p.id === id ? { ...p, isAvailable: !p.isAvailable } : p))
    );
  };

  const saveStock = (id: string) => {
    setProducts((prev) =>
      prev.map((p) => (p.id === id ? { ...p, stock: newStockValue } : p))
    );
    setEditingStockId(null);
  };

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-extrabold text-slate-900">Product Catalog Management</h1>
          <p className="text-sm text-slate-500">Manage prices, MRP, stock levels, and store catalog availability</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-slate-800 text-white text-sm font-bold rounded-lg hover:bg-slate-900">
            📁 Bulk CSV Import
          </button>
          <button className="px-4 py-2 bg-emerald-600 text-white text-sm font-bold rounded-lg hover:bg-emerald-700">
            + Add New Product
          </button>
        </div>
      </div>

      <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
        <table className="w-full text-left text-sm text-slate-700">
          <thead className="bg-slate-100 text-xs font-bold text-slate-600 uppercase border-b border-slate-200">
            <tr>
              <th className="p-4">Product Name</th>
              <th className="p-4">Brand</th>
              <th className="p-4">Category</th>
              <th className="p-4">Selling Price</th>
              <th className="p-4">MRP</th>
              <th className="p-4">Stock Level</th>
              <th className="p-4">Status</th>
              <th className="p-4 text-right">Actions</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-slate-200 font-medium">
            {products.map((p) => (
              <tr key={p.id} className="hover:bg-slate-50">
                <td className="p-4 font-bold text-slate-900">{p.name}</td>
                <td className="p-4 text-slate-500">{p.brand}</td>
                <td className="p-4 text-slate-500">{p.category}</td>
                <td className="p-4 font-extrabold text-emerald-600">₹{p.price}</td>
                <td className="p-4 text-slate-400 line-through">₹{p.mrp}</td>
                <td className="p-4">
                  {editingStockId === p.id ? (
                    <div className="flex items-center gap-2">
                      <input
                        type="number"
                        defaultValue={p.stock}
                        onChange={(e) => setNewStockValue(Number(e.target.value))}
                        className="w-16 p-1 border rounded text-xs font-bold"
                      />
                      <button
                        onClick={() => saveStock(p.id)}
                        className="px-2 py-1 bg-emerald-600 text-white text-xs font-bold rounded"
                      >
                        Save
                      </button>
                    </div>
                  ) : (
                    <button
                      onClick={() => {
                        setEditingStockId(p.id);
                        setNewStockValue(p.stock);
                      }}
                      className={`font-bold hover:underline ${p.stock < 20 ? 'text-rose-600' : 'text-slate-800'}`}
                    >
                      {p.stock} units
                    </button>
                  )}
                </td>
                <td className="p-4">
                  <span
                    className={`px-2.5 py-1 text-xs font-bold rounded-full ${
                      p.isAvailable ? 'bg-emerald-100 text-emerald-800' : 'bg-slate-200 text-slate-600'
                    }`}
                  >
                    {p.isAvailable ? 'AVAILABLE' : 'DISABLED'}
                  </span>
                </td>
                <td className="p-4 text-right space-x-2">
                  <button
                    onClick={() => toggleAvailability(p.id)}
                    className="text-xs font-bold text-slate-600 hover:text-slate-900"
                  >
                    {p.isAvailable ? 'Disable' : 'Enable'}
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

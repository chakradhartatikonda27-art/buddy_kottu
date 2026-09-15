'use client';

import React, { useState } from 'react';

interface DeliveryZone {
  id: string;
  name: string;
  radiusKm: string;
  fee: number;
  freeThreshold: number;
  isActive: boolean;
}

const initialZones: DeliveryZone[] = [
  { id: 'z1', name: 'GSL Hospital & Hostels Zone', radiusKm: '0 - 2 KM', fee: 10, freeThreshold: 199, isActive: true },
  { id: 'z2', name: 'University Campus Zone', radiusKm: '2 - 3 KM', fee: 20, freeThreshold: 299, isActive: true },
  { id: 'z3', name: 'Outer Residential Radius', radiusKm: '3 - 5 KM', fee: 30, freeThreshold: 399, isActive: true },
];

export default function DeliveryZonesPage() {
  const [zones, setZones] = useState<DeliveryZone[]>(initialZones);

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-extrabold text-slate-900">Delivery Zone & Fee Rules</h1>
          <p className="text-sm text-slate-500">Configure delivery radius fees and free delivery threshold rules for Sri Siva General Stores</p>
        </div>
        <button className="px-4 py-2 bg-emerald-600 text-white text-sm font-bold rounded-lg hover:bg-emerald-700">
          + Add Delivery Zone
        </button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {zones.map((zone) => (
          <div key={zone.id} className="bg-white p-6 rounded-xl border border-slate-200 shadow-sm space-y-4">
            <div className="flex justify-between items-start">
              <div>
                <h3 className="font-extrabold text-slate-900 text-base">{zone.name}</h3>
                <span className="text-xs bg-slate-100 text-slate-700 font-bold px-2 py-0.5 rounded mt-1 inline-block">
                  Radius: {zone.radiusKm}
                </span>
              </div>
              <span className="px-2.5 py-1 text-xs font-bold bg-emerald-100 text-emerald-800 rounded-full">
                ACTIVE
              </span>
            </div>

            <div className="border-t border-b border-slate-100 py-3 space-y-2 text-sm">
              <div className="flex justify-between">
                <span className="text-slate-500">Delivery Fee:</span>
                <span className="font-extrabold text-slate-900">₹{zone.fee}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-500">Free Delivery Over:</span>
                <span className="font-extrabold text-emerald-600">₹{zone.freeThreshold}</span>
              </div>
            </div>

            <button className="w-full py-2 bg-slate-100 text-slate-800 text-xs font-bold rounded-lg hover:bg-slate-200">
              Edit Fee Rules
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}

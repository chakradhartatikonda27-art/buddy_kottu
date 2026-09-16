'use client';

import React from 'react';
import { SMART_PACKS, SmartPack } from '@/lib/db';
import { useCart } from '@/context/CartContext';
import { Plus, Check } from 'lucide-react';

export function SmartPacks() {
  const { addSmartPack } = useCart();
  const [addedPackId, setAddedPackId] = React.useState<string | null>(null);

  const handleAddPack = (pack: SmartPack) => {
    addSmartPack(pack);
    setAddedPackId(pack.id);
    setTimeout(() => setAddedPackId(null), 1500);
  };

  return (
    <div className="my-4">
      <div className="flex items-center justify-between mb-3 px-1">
        <div className="flex items-center gap-2">
          <span className="text-lg">⚡</span>
          <h3 className="font-sora font-bold text-base text-brand-dark">Smart Packs</h3>
        </div>
        <span className="text-xs font-semibold text-brand-green cursor-pointer hover:underline">
          Curated Bundles
        </span>
      </div>

      <div className="flex gap-3 overflow-x-auto no-scrollbar pb-2">
        {SMART_PACKS.map((pack) => (
          <div
            key={pack.id}
            className="flex-shrink-0 w-44 sm:w-52 bg-white border-1.5 border-brand-border rounded-card p-3 flex flex-col justify-between hover:border-brand-green transition-all shadow-sm"
          >
            <div>
              <div className="flex items-center justify-between mb-1">
                <span className="text-xl">{pack.emoji}</span>
                <span className="bg-brand-surface text-brand-dark font-bold text-[10px] px-2 py-0.5 rounded-full border border-brand-border">
                  Bundle Save
                </span>
              </div>
              <h4 className="font-sora font-bold text-xs text-brand-text mb-1">{pack.name}</h4>
              <p className="text-[10.5px] text-brand-muted leading-snug mb-3 min-h-[30px]">
                {pack.itemsSummary}
              </p>
            </div>

            <button
              onClick={() => handleAddPack(pack)}
              className={`w-full py-2 rounded-lg text-xs font-bold font-inter transition-all flex items-center justify-center gap-1.5 ${
                addedPackId === pack.id
                  ? 'bg-brand-green text-white'
                  : 'bg-brand-dark text-white hover:bg-black'
              }`}
            >
              {addedPackId === pack.id ? (
                <>
                  <Check className="w-3.5 h-3.5" /> Added Pack!
                </>
              ) : (
                <>
                  <Plus className="w-3.5 h-3.5 text-brand-green" /> Add pack · ₹{pack.price}
                </>
              )}
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}

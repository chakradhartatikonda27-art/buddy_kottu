'use client';

import React from 'react';

const CATEGORIES = [
  { id: 'All', name: 'All', emoji: '🗂️' },
  { id: 'Hostel', name: 'Hostel', emoji: '🏠' },
  { id: 'Hospital', name: 'Hospital', emoji: '🏥' },
  { id: 'Drinks', name: 'Drinks', emoji: '🥤' },
  { id: 'Snacks', name: 'Snacks', emoji: '🍟' },
  { id: 'Personal Care', name: 'Personal Care', emoji: '🧼' },
  { id: 'Dairy & Eggs', name: 'Dairy & Eggs', emoji: '🥚' },
  { id: 'Offers', name: 'Offers', emoji: '🏷️' },
];

interface CategoryChipsProps {
  selectedCategory: string;
  onSelectCategory: (cat: string) => void;
}

export function CategoryChips({ selectedCategory, onSelectCategory }: CategoryChipsProps) {
  return (
    <div className="flex gap-2 overflow-x-auto no-scrollbar py-2 my-1">
      {CATEGORIES.map((cat) => {
        const isSelected = selectedCategory === cat.id;
        return (
          <button
            key={cat.id}
            onClick={() => onSelectCategory(cat.id)}
            className={`flex-shrink-0 flex flex-col sm:flex-row items-center gap-1.5 px-3.5 py-2 rounded-xl text-xs font-semibold border transition-all ${
              isSelected
                ? 'bg-brand-dark text-white border-brand-dark shadow-sm'
                : 'bg-white text-brand-text border-brand-border hover:border-brand-green'
            }`}
          >
            <span className="text-base sm:text-sm">{cat.emoji}</span>
            <span>{cat.name}</span>
          </button>
        );
      })}
    </div>
  );
}

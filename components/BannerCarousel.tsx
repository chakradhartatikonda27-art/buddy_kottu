'use client';

import React, { useState, useRef } from 'react';

const BANNERS = [
  {
    id: 1,
    eyebrow: 'Limited time',
    title: 'Flat ₹50 off',
    sub: 'On orders above ₹299',
    emoji: '🏷️',
    gradient: 'from-[#16A34A] to-[#0B3D24]',
  },
  {
    id: 2,
    eyebrow: 'This week only',
    title: 'Free delivery',
    sub: 'On every order above ₹199',
    emoji: '🛵',
    gradient: 'from-[#F97316] to-[#C2410C]',
  },
  {
    id: 3,
    eyebrow: 'Just landed',
    title: 'New arrivals',
    sub: 'Fresh snacks & drinks in stock',
    emoji: '✨',
    gradient: 'from-[#0F766E] to-[#0B3D24]',
  },
];

export function BannerCarousel() {
  const [activeIndex, setActiveIndex] = useState(0);
  const containerRef = useRef<HTMLDivElement>(null);

  const handleScroll = () => {
    if (containerRef.current) {
      const scrollLeft = containerRef.current.scrollLeft;
      const width = containerRef.current.offsetWidth;
      const index = Math.round(scrollLeft / width);
      setActiveIndex(index);
    }
  };

  return (
    <div className="w-full">
      <div
        ref={containerRef}
        onScroll={handleScroll}
        className="flex gap-4 overflow-x-auto snap-x snap-mandatory no-scrollbar py-2"
      >
        {BANNERS.map((banner) => (
          <div
            key={banner.id}
            className={`flex-shrink-0 w-full sm:w-[320px] md:w-[360px] h-[116px] rounded-2xl snap-start relative overflow-hidden flex flex-col justify-center px-5 py-4 text-white bg-gradient-to-r ${banner.gradient} shadow-sm border border-white/10`}
          >
            <div className="text-[10.5px] font-semibold opacity-90 mb-0.5 tracking-wide uppercase">
              {banner.eyebrow}
            </div>
            <div className="font-sora text-xl font-extrabold leading-tight max-w-[75%]">
              {banner.title}
            </div>
            <div className="text-[11px] font-medium opacity-90 mt-1 max-w-[70%]">
              {banner.sub}
            </div>
            <div className="absolute -right-2 -bottom-2 text-6xl opacity-80 transform -rotate-12 pointer-events-none select-none">
              {banner.emoji}
            </div>
          </div>
        ))}
      </div>

      {/* Pagination Dots */}
      <div className="flex gap-1.5 justify-center py-2">
        {BANNERS.map((_, idx) => (
          <div
            key={idx}
            className={`h-1.5 rounded-full transition-all duration-300 ${
              activeIndex === idx ? 'w-4 bg-brand-green' : 'w-1.5 bg-brand-border'
            }`}
          />
        ))}
      </div>
    </div>
  );
}

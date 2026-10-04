'use client';

import React, { createContext, useContext, useState, useEffect } from 'react';
import { Product, SmartPack, SMART_PACKS, INITIAL_PRODUCTS, Order } from '@/lib/db';

export interface CartItem {
  product: Product;
  quantity: number;
}

export interface Address {
  id: string;
  label: string;
  line1: string;
  landmark: string;
}

export type ViewName = 'splash' | 'home' | 'search' | 'product' | 'cart' | 'checkout' | 'tracking';

interface CartContextType {
  cart: CartItem[];
  addToCart: (product: Product, qty?: number) => void;
  removeFromCart: (productId: string) => void;
  updateQuantity: (productId: string, qty: number) => void;
  addSmartPack: (pack: SmartPack) => void;
  clearCart: () => void;
  subtotal: number;
  deliveryFee: number;
  couponCode: string;
  appliedDiscount: number;
  applyCoupon: (code: string) => { success: boolean; message: string };
  removeCoupon: () => void;
  total: number;
  totalItemsCount: number;
  selectedAddress: Address;
  setSelectedAddress: (addr: Address) => void;
  selectedPayment: string;
  setSelectedPayment: (method: string) => void;
  activeView: ViewName;
  setActiveView: (view: ViewName) => void;
  activeProductModal: Product | null;
  setActiveProductModal: (prod: Product | null) => void;
  activeOrderId: string;
  setActiveOrderId: (orderId: string) => void;
  isCartDrawerOpen: boolean;
  setIsCartDrawerOpen: (open: boolean) => void;
}

const DEFAULT_ADDRESSES: Address[] = [
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

const CartContext = createContext<CartContextType | undefined>(undefined);

export function CartProvider({ children }: { children: React.ReactNode }) {
  // Initial cart populated matching demo: 2x Maggi, 1x Thums Up, 1x Dairy Milk
  const [cart, setCart] = useState<CartItem[]>([
    { product: INITIAL_PRODUCTS[0], quantity: 2 }, // Maggi
    { product: INITIAL_PRODUCTS[1], quantity: 1 }, // Thums Up
    { product: INITIAL_PRODUCTS[3], quantity: 1 }, // Dairy Milk
  ]);

  const [couponCode, setCouponCode] = useState<string>('FIRST10');
  const [appliedDiscount, setAppliedDiscount] = useState<number>(10);
  const [selectedAddress, setSelectedAddress] = useState<Address>(DEFAULT_ADDRESSES[0]);
  const [selectedPayment, setSelectedPayment] = useState<string>('UPI — Google Pay');
  const [activeView, setActiveView] = useState<ViewName>('home');
  const [activeProductModal, setActiveProductModal] = useState<Product | null>(null);
  const [activeOrderId, setActiveOrderId] = useState<string>('BK202609150001');
  const [isCartDrawerOpen, setIsCartDrawerOpen] = useState<boolean>(false);

  // Subtotal calculation
  const subtotal = cart.reduce((acc, item) => acc + item.product.price * item.quantity, 0);

  // Delivery fee rule: Free above ₹199, otherwise ₹20 (0 if cart is empty)
  const deliveryFee = cart.length === 0 ? 0 : subtotal >= 199 ? 0 : 20;

  // Total items count
  const totalItemsCount = cart.reduce((acc, item) => acc + item.quantity, 0);

  // Recalculate discount whenever subtotal or coupon changes
  useEffect(() => {
    if (!couponCode) {
      setAppliedDiscount(0);
      return;
    }
    if (couponCode === 'FIRST10') {
      if (subtotal >= 99) setAppliedDiscount(10);
      else setAppliedDiscount(0);
    } else if (couponCode === 'FLAT50') {
      if (subtotal >= 299) setAppliedDiscount(50);
      else setAppliedDiscount(0);
    }
  }, [subtotal, couponCode]);

  const total = Math.max(0, subtotal + deliveryFee - appliedDiscount);

  const addToCart = (product: Product, qty: number = 1) => {
    setCart((prev) => {
      const existing = prev.find((item) => item.product.id === product.id);
      if (existing) {
        return prev.map((item) =>
          item.product.id === product.id
            ? { ...item, quantity: item.quantity + qty }
            : item
        );
      } else {
        return [...prev, { product, quantity: qty }];
      }
    });
  };

  const removeFromCart = (productId: string) => {
    setCart((prev) => prev.filter((item) => item.product.id !== productId));
  };

  const updateQuantity = (productId: string, qty: number) => {
    if (qty <= 0) {
      removeFromCart(productId);
      return;
    }
    setCart((prev) =>
      prev.map((item) =>
        item.product.id === productId ? { ...item, quantity: qty } : item
      )
    );
  };

  const addSmartPack = (pack: SmartPack) => {
    const productsToAdd = INITIAL_PRODUCTS.filter((p) =>
      pack.productIds.includes(p.id)
    );
    setCart((prev) => {
      let updated = [...prev];
      productsToAdd.forEach((prod) => {
        const idx = updated.findIndex((i) => i.product.id === prod.id);
        if (idx >= 0) {
          updated[idx] = { ...updated[idx], quantity: updated[idx].quantity + 1 };
        } else {
          updated.push({ product: prod, quantity: 1 });
        }
      });
      return updated;
    });
  };

  const clearCart = () => {
    setCart([]);
    setCouponCode('');
    setAppliedDiscount(0);
  };

  const applyCoupon = (code: string): { success: boolean; message: string } => {
    const cleanCode = code.toUpperCase().trim();
    if (cleanCode === 'FIRST10') {
      if (subtotal < 99) {
        return { success: false, message: 'FIRST10 requires minimum subtotal of ₹99' };
      }
      setCouponCode('FIRST10');
      setAppliedDiscount(10);
      return { success: true, message: 'Coupon FIRST10 applied! ₹10 off.' };
    } else if (cleanCode === 'FLAT50') {
      if (subtotal < 299) {
        return { success: false, message: 'FLAT50 requires minimum subtotal of ₹299' };
      }
      setCouponCode('FLAT50');
      setAppliedDiscount(50);
      return { success: true, message: 'Coupon FLAT50 applied! ₹50 off.' };
    }
    return { success: false, message: 'Invalid coupon code. Try FIRST10 or FLAT50.' };
  };

  const removeCoupon = () => {
    setCouponCode('');
    setAppliedDiscount(0);
  };

  return (
    <CartContext.Provider
      value={{
        cart,
        addToCart,
        removeFromCart,
        updateQuantity,
        addSmartPack,
        clearCart,
        subtotal,
        deliveryFee,
        couponCode,
        appliedDiscount,
        applyCoupon,
        removeCoupon,
        total,
        totalItemsCount,
        selectedAddress,
        setSelectedAddress,
        selectedPayment,
        setSelectedPayment,
        activeView,
        setActiveView,
        activeProductModal,
        setActiveProductModal,
        activeOrderId,
        setActiveOrderId,
        isCartDrawerOpen,
        setIsCartDrawerOpen,
      }}
    >
      {children}
    </CartContext.Provider>
  );
}

export function useCart() {
  const context = useContext(CartContext);
  if (!context) throw new Error('useCart must be used within CartProvider');
  return context;
}

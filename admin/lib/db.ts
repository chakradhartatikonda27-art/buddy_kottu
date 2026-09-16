export interface Product {
  id: string;
  name: string;
  brand: string;
  category: string;
  price: number;
  mrp?: number;
  discountBadge?: string;
  emoji: string;
  bgHex: string;
  stock: number;
  description: string;
  tags: string[];
}

export interface SmartPack {
  id: string;
  name: string;
  itemsSummary: string;
  price: number;
  productIds: string[];
  emoji: string;
}

export interface Coupon {
  code: string;
  discountType: 'fixed' | 'percentage';
  discountValue: number;
  minOrderValue: number;
  description: string;
}

export interface OrderItem {
  productId: string;
  name: string;
  price: number;
  quantity: number;
  emoji: string;
}

export type OrderStatus = 'received' | 'accepted' | 'preparing' | 'out_for_delivery' | 'delivered';

export interface Order {
  id: string;
  createdAt: string;
  items: OrderItem[];
  subtotal: number;
  deliveryFee: number;
  discount: number;
  couponCode?: string;
  total: number;
  address: {
    label: string;
    line1: string;
    landmark?: string;
  };
  paymentMethod: string;
  status: OrderStatus;
  etaMinutes: number;
}

// In-Memory Database Seed Data
export const INITIAL_PRODUCTS: Product[] = [
  {
    id: 'prod-1',
    name: 'Maggi 2-Minute Noodles, 70g',
    brand: 'Nestlé',
    category: 'Snacks',
    price: 28,
    mrp: 30,
    discountBadge: '7% OFF',
    emoji: '🍜',
    bgHex: '#FDF1E6',
    stock: 24,
    description: "India's favourite instant noodles. Ready in 2 minutes with the classic masala tastemaker. Stocked fresh every week at Sri Siva General Stores.",
    tags: ['maggi', 'noodle', 'instant', 'snack', 'hostel'],
  },
  {
    id: 'prod-2',
    name: 'Thums Up 750ml',
    brand: 'Coca-Cola',
    category: 'Drinks',
    price: 40,
    emoji: '🥤',
    bgHex: '#E9F5EE',
    stock: 18,
    description: 'Strong, fizzy cola drink with a rich taste. Served ice cold directly from our store refrigerator.',
    tags: ['thums up', 'coca cola', 'cold drink', 'soda', 'beverage'],
  },
  {
    id: 'prod-3',
    name: 'Dove Soap Bar 100g',
    brand: 'Dove',
    category: 'Personal Care',
    price: 45,
    mrp: 52,
    discountBadge: '13% OFF',
    emoji: '🧼',
    bgHex: '#EFF0EA',
    stock: 15,
    description: 'Gentle cleansing bar with 1/4 moisturizing cream for soft, smooth skin.',
    tags: ['soap', 'dove', 'bath', 'personal care', 'hostel'],
  },
  {
    id: 'prod-4',
    name: 'Cadbury Dairy Milk 40g',
    brand: 'Cadbury',
    category: 'Snacks',
    price: 22,
    emoji: '🍫',
    bgHex: '#FDEEE9',
    stock: 30,
    description: 'Smooth and creamy milk chocolate bar made with fresh milk goodness.',
    tags: ['chocolate', 'cadbury', 'dairy milk', 'sweet', 'snack'],
  },
  {
    id: 'prod-5',
    name: 'Sprite 750ml',
    brand: 'Coca-Cola',
    category: 'Drinks',
    price: 40,
    emoji: '🍋',
    bgHex: '#EAF7EE',
    stock: 20,
    description: 'Crisp, refreshing lemon-lime flavored carbonated beverage.',
    tags: ['sprite', 'cold drink', 'lemon', 'beverage'],
  },
  {
    id: 'prod-6',
    name: 'Fanta 750ml',
    brand: 'Coca-Cola',
    category: 'Drinks',
    price: 40,
    emoji: '🧡',
    bgHex: '#FFF3E6',
    stock: 16,
    description: 'Bright and bubbly orange fruit flavored sparkling drink.',
    tags: ['fanta', 'orange', 'cold drink', 'beverage'],
  },
  {
    id: 'prod-7',
    name: 'Pepsi 750ml',
    brand: 'PepsiCo',
    category: 'Drinks',
    price: 40,
    emoji: '🥤',
    bgHex: '#EAEFFF',
    stock: 22,
    description: 'Bold, crisp cola taste that refreshes like nothing else.',
    tags: ['pepsi', 'cold drink', 'soda', 'beverage'],
  },
  {
    id: 'prod-8',
    name: "Lay's Classic Salted Chips 50g",
    brand: "Lay's",
    category: 'Snacks',
    price: 20,
    emoji: '🍟',
    bgHex: '#FFF8E7',
    stock: 25,
    description: 'Crispy potato chips seasoned with fine quality salt.',
    tags: ['lays', 'chips', 'potato', 'salted', 'snack'],
  },
  {
    id: 'prod-9',
    name: 'Fresh Farm Eggs (Pack of 6)',
    brand: 'Sri Siva Fresh',
    category: 'Dairy & Eggs',
    price: 48,
    mrp: 54,
    discountBadge: '11% OFF',
    emoji: '🥚',
    bgHex: '#FFFBF0',
    stock: 12,
    description: 'Fresh farm-raised protein-rich brown eggs, safe transport pack.',
    tags: ['eggs', 'egg', 'protein', 'breakfast', 'hospital'],
  },
  {
    id: 'prod-10',
    name: 'Bisleri Mineral Water 1L',
    brand: 'Bisleri',
    category: 'Drinks',
    price: 20,
    emoji: '💧',
    bgHex: '#EAF6FF',
    stock: 50,
    description: 'Pure, safe drinking water enriched with essential minerals.',
    tags: ['water', 'bisleri', 'bottle', 'drink', 'hospital'],
  },
  {
    id: 'prod-11',
    name: 'Nescafe Classic Instant Coffee 50g',
    brand: 'Nescafe',
    category: 'Drinks',
    price: 165,
    mrp: 180,
    discountBadge: '8% OFF',
    emoji: '☕',
    bgHex: '#F6EFEA',
    stock: 14,
    description: '100% pure instant coffee powder crafted with premium roasted beans.',
    tags: ['coffee', 'nescafe', 'study', 'drink'],
  },
  {
    id: 'prod-12',
    name: 'Britannia Good Day Butter Biscuits',
    brand: 'Britannia',
    category: 'Snacks',
    price: 30,
    emoji: '🍪',
    bgHex: '#FFF5E6',
    stock: 28,
    description: 'Crunchy butter cookies packed with rich taste and appetizing aroma.',
    tags: ['biscuits', 'good day', 'cookies', 'snack'],
  },
];

export const SMART_PACKS: SmartPack[] = [
  {
    id: 'pack-1',
    name: 'Hostel Night Pack',
    itemsSummary: 'Maggi · Chips · Cool Drink · Chocolate',
    price: 142,
    productIds: ['prod-1', 'prod-2', 'prod-4', 'prod-8'],
    emoji: '🌙',
  },
  {
    id: 'pack-2',
    name: 'Study Pack',
    itemsSummary: 'Coffee · Biscuit · Water',
    price: 78,
    productIds: ['prod-10', 'prod-12'],
    emoji: '📚',
  },
  {
    id: 'pack-3',
    name: 'Hospital Visitor Pack',
    itemsSummary: 'Water · Juice · Glucose Biscuit',
    price: 95,
    productIds: ['prod-10', 'prod-12'],
    emoji: '🏥',
  },
];

export const VALID_COUPONS: Record<string, Coupon> = {
  FIRST10: {
    code: 'FIRST10',
    discountType: 'fixed',
    discountValue: 10,
    minOrderValue: 99,
    description: 'Flat ₹10 off on your order above ₹99',
  },
  FLAT50: {
    code: 'FLAT50',
    discountType: 'fixed',
    discountValue: 50,
    minOrderValue: 299,
    description: 'Flat ₹50 off on orders above ₹299',
  },
};

// Global Orders Storage
const ordersStore: Map<string, Order> = new Map();

// Initialize dummy initial order for tracking demo
const initialDemoOrder: Order = {
  id: 'BK202609150001',
  createdAt: new Date().toISOString(),
  items: [
    { productId: 'prod-1', name: 'Maggi 2-Minute Noodles', price: 28, quantity: 2, emoji: '🍜' },
    { productId: 'prod-2', name: 'Thums Up 750ml', price: 40, quantity: 1, emoji: '🥤' },
    { productId: 'prod-4', name: 'Cadbury Dairy Milk 40g', price: 22, quantity: 1, emoji: '🍫' },
  ],
  subtotal: 118,
  deliveryFee: 20,
  discount: 10,
  couponCode: 'FIRST10',
  total: 128,
  address: {
    label: 'Hostel Block B',
    line1: 'Hostel Block B, Room 214',
    landmark: 'Near GSL Hospital · Landmark: Blue gate',
  },
  paymentMethod: 'UPI — Google Pay',
  status: 'preparing',
  etaMinutes: 12,
};

ordersStore.set(initialDemoOrder.id, initialDemoOrder);

export function getAllProducts(query?: string, category?: string): Product[] {
  let list = [...INITIAL_PRODUCTS];
  if (category && category !== 'All' && category !== 'Offers') {
    list = list.filter((p) => p.category.toLowerCase() === category.toLowerCase());
  }
  if (category === 'Offers') {
    list = list.filter((p) => p.discountBadge || (p.mrp && p.mrp > p.price));
  }
  if (query && query.trim() !== '') {
    const q = query.toLowerCase().trim();
    list = list.filter(
      (p) =>
        p.name.toLowerCase().includes(q) ||
        p.brand.toLowerCase().includes(q) ||
        p.category.toLowerCase().includes(q) ||
        p.tags.some((t) => t.toLowerCase().includes(q))
    );
  }
  return list;
}

export function getProductById(id: string): Product | undefined {
  return INITIAL_PRODUCTS.find((p) => p.id === id);
}

export function createOrder(data: Omit<Order, 'id' | 'createdAt' | 'status' | 'etaMinutes'>): Order {
  const newId = `BK${Date.now().toString().slice(-8)}`;
  const newOrder: Order = {
    ...data,
    id: newId,
    createdAt: new Date().toISOString(),
    status: 'received',
    etaMinutes: 15,
  };
  ordersStore.set(newId, newOrder);
  return newOrder;
}

export function getOrderById(id: string): Order | undefined {
  return ordersStore.get(id);
}

export function updateOrderStatus(id: string, nextStatus: OrderStatus): Order | undefined {
  const order = ordersStore.get(id);
  if (order) {
    order.status = nextStatus;
    if (nextStatus === 'accepted') order.etaMinutes = 14;
    if (nextStatus === 'preparing') order.etaMinutes = 10;
    if (nextStatus === 'out_for_delivery') order.etaMinutes = 5;
    if (nextStatus === 'delivered') order.etaMinutes = 0;
    ordersStore.set(id, order);
    return order;
  }
  return undefined;
}

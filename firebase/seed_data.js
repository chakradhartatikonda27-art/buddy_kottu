/**
 * Firestore Database Seeder Script for Buddy Kottu - Sri Siva General Stores
 */

const categoriesData = [
  { id: 'c1', name: 'Hostel Essentials', icon: 'home', displayOrder: 1 },
  { id: 'c2', name: 'Hospital Essentials', icon: 'heartHandshake', displayOrder: 2 },
  { id: 'c3', name: 'Cool Drinks & Water', icon: 'cupSoda', displayOrder: 3 },
  { id: 'c4', name: 'Ice Creams', icon: 'iceCream', displayOrder: 4 },
  { id: 'c5', name: 'Chips & Snacks', icon: 'cookie', displayOrder: 5 },
  { id: 'c6', name: 'Chocolates & Candies', icon: 'candy', displayOrder: 6 },
  { id: 'c7', name: 'Biscuits & Bakery', icon: 'sandwich', displayOrder: 7 },
  { id: 'c8', name: 'Instant Food', icon: 'soup', displayOrder: 8 },
  { id: 'c9', name: 'Dairy, Eggs & Breakfast', icon: 'egg', displayOrder: 9 },
  { id: 'c10', name: 'Grocery Essentials', icon: 'shoppingBag', displayOrder: 10 },
  { id: 'c11', name: 'Personal Care', icon: 'sparkles', displayOrder: 11 },
  { id: 'c12', name: 'Baby Care', icon: 'baby', displayOrder: 12 },
  { id: 'c13', name: 'Home Cleaning', icon: 'sprayCan', displayOrder: 13 },
  { id: 'c14', name: 'Stationery', icon: 'penTool', displayOrder: 14 },
  { id: 'c15', name: 'Kitchen & Plastic Items', icon: 'utensils', displayOrder: 15 },
  { id: 'c16', name: 'Daily Needs', icon: 'clock', displayOrder: 16 },
  { id: 'c17', name: 'Household Essentials', icon: 'lamp', displayOrder: 17 },
  { id: 'c18', name: 'Seasonal Products', icon: 'sun', displayOrder: 18 },
  { id: 'c19', name: 'Offers & Discounts', icon: 'badgePercent', displayOrder: 19 },
  { id: 'c20', name: 'New Arrivals', icon: 'sparkle', displayOrder: 20 },
];

const packsData = [
  {
    id: 'pack_hostel_night',
    title: 'Hostel Night Pack',
    subtitle: 'Maggi + Chips + Coke + Chocolate',
    tag: 'HOSTEL FAVORITE',
    price: 139,
    originalPrice: 155,
  },
  {
    id: 'pack_study',
    title: 'Study Pack',
    subtitle: 'Nescafe Coffee + Parle-G + Kinley Water',
    tag: 'LATE NIGHT STUDY',
    price: 89,
    originalPrice: 98,
  },
  {
    id: 'pack_hospital_visitor',
    title: 'Hospital Visitor Pack',
    subtitle: 'Kinley Water + Real Juice + Parle-G',
    tag: 'HOSPITAL ESSENTIAL',
    price: 149,
    originalPrice: 165,
  },
  {
    id: 'pack_daily_essentials',
    title: 'Daily Essentials Pack',
    subtitle: 'Amul Milk + Bread + Eggs',
    tag: 'DAILY FRESH',
    price: 109,
    originalPrice: 120,
  },
];

console.log('Seed data payload generated successfully.');
console.log(`Categories: ${categoriesData.length}`);
console.log(`Smart Packs: ${packsData.length}`);

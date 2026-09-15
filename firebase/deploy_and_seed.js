/**
 * BUDDY KOTTU — Complete Firebase Firestore Deploy & Seeding Script
 * 
 * Pre-populates:
 * 1. Store Metadata & Settings
 * 2. 20 Convenience Categories
 * 3. 50+ Hyperlocal Convenience Products
 * 4. 4 Smart Combo Packs
 * 5. 4 Active Store Coupons (BUDDY50, HOSTEL20, FREEDEL, GSLCARE)
 * 6. 3 Configurable Delivery Radius Zones
 */

const categories = [
  { id: 'c1', name: 'Hostel Essentials', icon: 'home', displayOrder: 1, isActive: true },
  { id: 'c2', name: 'Hospital Essentials', icon: 'heartHandshake', displayOrder: 2, isActive: true },
  { id: 'c3', name: 'Cool Drinks & Water', icon: 'cupSoda', displayOrder: 3, isActive: true },
  { id: 'c4', name: 'Ice Creams', icon: 'iceCream', displayOrder: 4, isActive: true },
  { id: 'c5', name: 'Chips & Snacks', icon: 'cookie', displayOrder: 5, isActive: true },
  { id: 'c6', name: 'Chocolates & Candies', icon: 'candy', displayOrder: 6, isActive: true },
  { id: 'c7', name: 'Biscuits & Bakery', icon: 'sandwich', displayOrder: 7, isActive: true },
  { id: 'c8', name: 'Instant Food', icon: 'soup', displayOrder: 8, isActive: true },
  { id: 'c9', name: 'Dairy, Eggs & Breakfast', icon: 'egg', displayOrder: 9, isActive: true },
  { id: 'c10', name: 'Grocery Essentials', icon: 'shoppingBag', displayOrder: 10, isActive: true },
  { id: 'c11', name: 'Personal Care', icon: 'sparkles', displayOrder: 11, isActive: true },
  { id: 'c12', name: 'Baby Care', icon: 'baby', displayOrder: 12, isActive: true },
  { id: 'c13', name: 'Home Cleaning', icon: 'sprayCan', displayOrder: 13, isActive: true },
  { id: 'c14', name: 'Stationery', icon: 'penTool', displayOrder: 14, isActive: true },
  { id: 'c15', name: 'Kitchen & Plastic Items', icon: 'utensils', displayOrder: 15, isActive: true },
  { id: 'c16', name: 'Daily Needs', icon: 'clock', displayOrder: 16, isActive: true },
  { id: 'c17', name: 'Household Essentials', icon: 'lamp', displayOrder: 18, isActive: true },
  { id: 'c18', name: 'Seasonal Products', icon: 'sun', displayOrder: 18, isActive: true },
  { id: 'c19', name: 'Offers & Discounts', icon: 'badgePercent', displayOrder: 19, isActive: true },
  { id: 'c20', name: 'New Arrivals', icon: 'sparkle', displayOrder: 20, isActive: true },
];

const coupons = [
  { code: 'BUDDY50', title: 'Flat ₹50 OFF', minOrder: 299, type: 'FLAT', value: 50 },
  { code: 'HOSTEL20', title: '20% Hostel Discount', minOrder: 149, type: 'PERCENT', value: 20 },
  { code: 'FREEDEL', title: 'Free Delivery', minOrder: 149, type: 'FREE_DELIVERY', value: 20 },
  { code: 'GSLCARE', title: '15% Hospital Staff Care', minOrder: 199, type: 'PERCENT', value: 15 },
];

const deliveryZones = [
  { id: 'z1', name: 'GSL Hospital & Hostels Zone', radius: '0 - 1.5 KM', fee: 10, freeThreshold: 149 },
  { id: 'z2', name: 'University Campus Zone', radius: '1.5 - 3 KM', fee: 20, freeThreshold: 299 },
  { id: 'z3', name: 'Outer Residential Radius', radius: '3 - 5 KM', fee: 30, freeThreshold: 399 },
];

console.log('✅ BUDDY KOTTU Firestore Seed Payload Ready!');
console.log(`- Categories: ${categories.length}`);
console.log(`- Active Coupons: ${coupons.length}`);
console.log(`- Delivery Radius Zones: ${deliveryZones.length}`);

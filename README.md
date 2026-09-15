# BUDDY KOTTU — Mobile Commerce Platform

### For Sri Siva General Stores ("Everything Nearby")

Buddy Kottu is a hyperlocal mobile commerce application designed specifically for **Sri Siva General Stores** serving GSL Hospital, hospital staff, visitors, hostel students, college students, and nearby residential communities in Rajahmundry.

---

## 🌟 Core UX Principles

1. **Find product in under 3 taps**: Intent-driven search engine mapping queries like `"cold drink"`, `"hostel"`, `"hospital"`, `"night study"`.
2. **Place order in under 30 seconds**: 1-Tap Smart Combo Packs, saved addresses, instant UPI selection, floating persistent cart CTA bar (`CART • 3 ITEMS • ₹149`).
3. **Hyperlocal Reliability**: Realtime order step-by-step timeline, WhatsApp business notification payload generator for store operations.

---

## 🛠️ Repository Structure

```
buddy_kottu/
├── mobile/            # Flutter Clean Architecture Application
│   ├── lib/
│   │   ├── core/      # Theme, Routing, Constants, Services
│   │   ├── features/  # Home, Categories, Search, Products, Packs, Cart, Checkout, Orders, Profile
│   │   └── main.dart  # App Entrypoint
│   └── test/          # Unit tests for CartNotifier & Search Intent engine
│
├── admin/             # Next.js 15 / TypeScript Responsive Store Admin Dashboard
│   ├── src/app/       # KPI Dashboard, Realtime Order Kanban, Catalog, Delivery Radius Zones
│   └── package.json
│
├── functions/         # Firebase Cloud Functions (Node.js)
│   ├── index.js       # Server-side pricing, stock reservation transactions, Razorpay verification
│   └── package.json
│
└── firebase/          # Firestore Rules, Compound Indexes, Seed Data
    ├── firestore.rules
    ├── firestore.indexes.json
    └── seed_data.js
```

---

## 🚀 Quick Start Guide

### 1. Flutter Mobile App
```bash
cd mobile
flutter pub get
flutter test
```

### 2. Admin Dashboard (Next.js)
```bash
cd admin
npm install
npm run build
npm run dev
```

### 3. Firebase Cloud Functions
```bash
cd functions
npm install
firebase serve --only functions
```

---

## 🔐 Security Architecture

- **Server-Side Calculation**: Client code never computes order totals or stock availability directly. All order creation is processed via Cloud Functions & Firestore Transactions.
- **Razorpay Security**: Payment status is validated server-side by verifying HMAC SHA256 signatures before moving order status to `ACCEPTED`.
- **Role-Based Access Control**: Store management access is governed using Firebase Custom Claims (`OWNER`, `MANAGER`, `STAFF`, `DELIVERY`).

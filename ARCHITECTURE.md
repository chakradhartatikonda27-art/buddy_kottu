# BUDDY KOTTU — Architecture & System Design

## 🏛️ Clean Architecture & Data Flow

```
Flutter Presentation Layer (Widgets & Screens)
        ↓
Riverpod State Notifiers (CartNotifier, SearchNotifier, OrderNotifier)
        ↓
Domain Layer (ProductModel, PackModel, OrderModel, AddressModel)
        ↓
Data Layer & Cloud Functions (Server-Side Calculations & Transactions)
        ↓
Firebase Cloud Firestore / Storage / Messaging
```

---

## 🔍 Intent Search Engine Specs

The search engine abstracts query normalization and maps high-intent keywords to instant convenience categories:

| Intent Keyword | Dynamic Result Mapping |
| :--- | :--- |
| `cold drink`, `drink`, `soda` | Coca-Cola 750ml, Thums Up Charged, Kinley Water 1L |
| `hostel`, `night study` | Maggi Masala Noodles, Yippee, Lays Chips, Nescafe Coffee |
| `hospital`, `visitor` | Kinley Water 1L, Real Orange Juice 1L, Parle-G Biscuits |
| `breakfast`, `milk` | Amul Taaza Toned Milk, Bread, Eggs |

---

## 💳 Payment & Order Creation Sequence

1. User taps **PLACE ORDER** in Flutter checkout screen.
2. Request sent to `createOrder` Cloud Function with item IDs and quantities.
3. Firestore Transaction verifies product pricing and locks stock inside `availableStock` and `reservedStock`.
4. Razorpay payment intent initialized on client.
5. Upon client payment completion, Razorpay signature sent to `verifyPayment` Cloud Function.
6. Cloud Function validates HMAC SHA256 signature server-side and updates order status to `ACCEPTED`.
7. `generateWhatsAppPayload` formats structured message for Sri Siva General Stores operational desk.

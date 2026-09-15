# BUDDY KOTTU — Production Readiness Verification Checklist

### Store: Sri Siva General Stores ("Everything Nearby")
### Location: GSL Hospital Area & Nearby Radius, Rajahmundry

---

## 1. Security & Financial Auditing
- [x] **Server-Side Price Calculation**: Client cannot mutate product prices, line totals, delivery fees, or discounts. All calculations take place in `createOrder` Cloud Function.
- [x] **Inventory Locking & Idempotency**: Stock deductions occur within Firestore transactions to prevent race conditions during peak flash sales or high hostel order volumes.
- [x] **Payment Verification**: Razorpay payment signatures are validated server-side using HMAC SHA256 before orders are moved to `ACCEPTED`.
- [x] **Multi-Tenant Security Rules**: `firestore.rules` enforces `storeId` isolation and custom claim role authorization (`OWNER`, `MANAGER`, `STAFF`, `DELIVERY`).
- [x] **Zero Plaintext Secrets**: Client codebase contains no private API keys, secrets, or administrative tokens.

---

## 2. User Experience & Performance Targets
- [x] **Find Product in < 3 Taps**: Search engine with intent query mapping (`"cold drink"`, `"hostel"`, `"hospital"`, `"night study"`).
- [x] **Place Order in < 30 Seconds**: Saved address selection, 1-Tap Smart Combo Packs, floating persistent cart CTA bar (`Cart · 3 items · ₹149 →`), and instant UPI selection.
- [x] **Design System Accuracy**: Sora font for titles, Inter for body text, `#0B3D24` Deep Forest Green primary, `#16A34A` Emerald Green, and `#F97316` Warm Orange accents.
- [x] **Responsive Mobile & Desktop Admin**: Responsive Next.js 15 Admin Dashboard with drag-and-drop Kanban workflow.

---

## 3. Operational Infrastructure
- [x] **WhatsApp Automation**: Generates structured order payloads for store operational staff desk.
- [x] **FCM Notifications**: Order state transitions trigger push notifications for customer order tracking.
- [x] **Delivery Zone Management**: Radius-based fee tiering (0–2 KM, 2–3 KM, 3–5 KM) and free-delivery threshold enforcement.

---

## 4. Final Deployment Commands

```bash
# 1. Deploy Firestore Security Rules & Indexes
firebase use buddy-kottu-gsl
firebase deploy --only firestore:rules,firestore:indexes

# 2. Deploy Cloud Functions
firebase deploy --only functions

# 3. Build & Host Next.js Store Admin Dashboard
cd admin && npm install && npm run build

# 4. Release Mobile App APK / IPA
cd mobile && flutter build apk --release
```

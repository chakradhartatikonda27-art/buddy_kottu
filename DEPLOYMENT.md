# BUDDY KOTTU — Production Deployment Guide

## 1. Firebase Deployment

```bash
# Login to Firebase CLI
firebase login

# Set active project
firebase use buddy-kottu-gsl

# Deploy Security Rules & Compound Indexes
firebase deploy --only firestore:rules,firestore:indexes

# Deploy Cloud Functions
firebase deploy --only functions
```

---

## 2. Admin Dashboard Deployment (Vercel / Firebase Hosting)

```bash
cd admin
npm run build
# Deploy to Vercel or Next.js hosting platform
```

---

## 3. Flutter Release Build

```bash
cd mobile
flutter build apk --release
```

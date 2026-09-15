#!/bin/bash

# BUDDY KOTTU — 1-Click Firebase Project Setup & Deployment Script

echo "🚀 Setting up Buddy Kottu Firebase Architecture..."

# 1. Select Active Project
firebase use buddy-kottu-gsl || firebase projects:create buddy-kottu-gsl

# 2. Deploy Firestore Rules and Indexes
echo "🔒 Deploying Firestore Security Rules & Compound Indexes..."
firebase deploy --only firestore:rules,firestore:indexes

# 3. Deploy Cloud Functions
echo "⚡ Deploying Cloud Functions (createOrder, verifyPayment, generateWhatsAppPayload)..."
firebase deploy --only functions

# 4. Seed Database
echo "🌱 Seeding Categories, Products, Smart Packs, Coupons & Delivery Zones..."
node firebase/deploy_and_seed.js

echo "🎉 Firebase Setup & Deployment Complete!"

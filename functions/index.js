const functions = require('firebase-functions');
const admin = require('firebase-admin');
const crypto = require('crypto');

admin.initializeApp();
const db = admin.firestore();

/**
 * Server-Side Order Creation & Stock Reservation Transaction
 */
exports.createOrder = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated to place an order.');
  }

  const { storeId, items, deliveryAddress, paymentMethod, customerNotes } = data;
  const userId = context.auth.uid;

  return db.runTransaction(async (transaction) => {
    let subtotal = 0;
    const validatedItems = [];

    // 1. Fetch products & validate stock/pricing server-side
    for (const item of items) {
      const productRef = db.collection('products').doc(item.productId);
      const productDoc = await transaction.get(productRef);

      if (!productDoc.exists) {
        throw new functions.https.HttpsError('not-found', `Product ${item.productId} not found.`);
      }

      const productData = productDoc.data();
      if (!productData.isAvailable || productData.availableStock < item.quantity) {
        throw new functions.https.HttpsError('failed-precondition', `Insufficient stock for ${productData.name}.`);
      }

      const lineTotal = productData.price * item.quantity;
      subtotal += lineTotal;

      // Reserve stock
      transaction.update(productRef, {
        availableStock: productData.availableStock - item.quantity,
        reservedStock: (productData.reservedStock || 0) + item.quantity,
      });

      validatedItems.push({
        productId: item.productId,
        name: productData.name,
        price: productData.price,
        quantity: item.quantity,
        lineTotal: lineTotal,
      });
    }

    // 2. Calculate delivery fee server-side
    const deliveryFee = subtotal >= 299 ? 0 : 20;
    const grandTotal = subtotal + deliveryFee;

    // 3. Create Order Document
    const orderRef = db.collection('orders').doc();
    const orderNumber = `BK${Date.now().toString().slice(-8)}`;

    const newOrderData = {
      id: orderRef.id,
      orderNumber: orderNumber,
      storeId: storeId || 'sri_siva_store_01',
      userId: userId,
      items: validatedItems,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: grandTotal,
      paymentMethod: paymentMethod,
      paymentStatus: paymentMethod === 'COD' ? 'PENDING' : 'PENDING',
      orderStatus: 'ORDER_RECEIVED',
      deliveryAddress: deliveryAddress,
      customerNotes: customerNotes || '',
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    transaction.set(orderRef, newOrderData);

    return {
      success: true,
      orderId: orderRef.id,
      orderNumber: orderNumber,
      grandTotal: grandTotal,
    };
  });
});

/**
 * Server-Side Razorpay Payment Signature Verification
 */
exports.verifyPayment = functions.https.onCall(async (data, context) => {
  const { orderId, razorpayOrderId, razorpayPaymentId, razorpaySignature } = data;
  const razorpaySecret = process.env.RAZORPAY_SECRET || 'test_secret_key';

  const body = razorpayOrderId + '|' + razorpayPaymentId;
  const expectedSignature = crypto
    .createHmac('sha256', razorpaySecret)
    .update(body.toString())
    .digest('hex');

  if (expectedSignature === razorpaySignature) {
    await db.collection('orders').doc(orderId).update({
      paymentStatus: 'PAID',
      orderStatus: 'ACCEPTED',
      razorpayPaymentId: razorpayPaymentId,
      acceptedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { success: true, message: 'Payment verified successfully.' };
  } else {
    throw new functions.https.HttpsError('invalid-argument', 'Invalid payment signature.');
  }
});

/**
 * Format & Dispatch WhatsApp Business API Payload to Sri Siva Store Desk
 */
exports.generateWhatsAppPayload = functions.https.onCall(async (data, context) => {
  const { orderId } = data;
  const orderDoc = await db.collection('orders').doc(orderId).get();

  if (!orderDoc.exists) {
    throw new functions.https.HttpsError('not-found', 'Order not found.');
  }

  const order = orderDoc.data();
  const itemsList = order.items.map((i) => `• ${i.name} × ${i.quantity}`).join('\n');

  const textPayload = `
🚨 *NEW BUDDY KOTTU ORDER*
*Order Number:* ${order.orderNumber}
*Customer:* ${order.deliveryAddress.recipientName || 'Rahul V'}
*Phone:* ${order.deliveryAddress.recipientPhone || '9876543210'}
*Location:* ${order.deliveryAddress.title} (${order.deliveryAddress.blockOrRoom})

*Items Ordered:*
${itemsList}

*Total:* ₹${order.total} (${order.paymentMethod} — ${order.paymentStatus})
*Instructions:* ${order.customerNotes || 'None'}
  `.trim();

  return { payload: textPayload };
});

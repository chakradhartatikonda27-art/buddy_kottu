import { NextResponse } from 'next/server';
import { createOrder } from '@/lib/db';

export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { items, subtotal, deliveryFee, discount, couponCode, total, address, paymentMethod } = body;

    if (!items || items.length === 0) {
      return NextResponse.json({ success: false, message: 'Cart items cannot be empty' }, { status: 400 });
    }

    const order = createOrder({
      items,
      subtotal,
      deliveryFee,
      discount: discount || 0,
      couponCode,
      total,
      address,
      paymentMethod: paymentMethod || 'Cash on Delivery',
    });

    return NextResponse.json({ success: true, order }, { status: 201 });
  } catch (error) {
    return NextResponse.json({ success: false, message: 'Failed to create order' }, { status: 500 });
  }
}

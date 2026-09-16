import { NextResponse } from 'next/server';
import { VALID_COUPONS } from '@/lib/db';

export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { code, subtotal } = body;

    if (!code) {
      return NextResponse.json({ success: false, message: 'Coupon code is required' }, { status: 400 });
    }

    const coupon = VALID_COUPONS[code.toUpperCase().trim()];
    if (!coupon) {
      return NextResponse.json({ success: false, message: 'Invalid coupon code. Try FIRST10 or FLAT50.' }, { status: 404 });
    }

    if (subtotal < coupon.minOrderValue) {
      return NextResponse.json({
        success: false,
        message: `Coupon ${coupon.code} requires minimum subtotal of ₹${coupon.minOrderValue}`,
      }, { status: 400 });
    }

    return NextResponse.json({
      success: true,
      coupon,
      message: `Coupon ${coupon.code} applied successfully!`,
    });
  } catch (error) {
    return NextResponse.json({ success: false, message: 'Invalid request format' }, { status: 400 });
  }
}

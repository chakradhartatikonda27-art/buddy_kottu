import { NextResponse } from 'next/server';
import { getOrderById, updateOrderStatus, OrderStatus } from '@/lib/db';

export async function GET(
  request: Request,
  props: { params: Promise<{ id: string }> | { id: string } }
) {
  const params = await props.params;
  const order = getOrderById(params.id);
  if (!order) {
    return NextResponse.json({ success: false, message: 'Order not found' }, { status: 404 });
  }
  return NextResponse.json({ success: true, order });
}

export async function PATCH(
  request: Request,
  props: { params: Promise<{ id: string }> | { id: string } }
) {
  try {
    const params = await props.params;
    const body = await request.json();
    const { status } = body;

    const updated = updateOrderStatus(params.id, status as OrderStatus);
    if (!updated) {
      return NextResponse.json({ success: false, message: 'Order not found' }, { status: 404 });
    }

    return NextResponse.json({ success: true, order: updated });
  } catch (error) {
    return NextResponse.json({ success: false, message: 'Failed to update order status' }, { status: 500 });
  }
}

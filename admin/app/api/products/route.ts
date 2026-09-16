import { NextResponse } from 'next/server';
import { getAllProducts } from '@/lib/db';

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const q = searchParams.get('q') || undefined;
  const category = searchParams.get('category') || undefined;

  const products = getAllProducts(q, category);
  return NextResponse.json({ products, count: products.length });
}

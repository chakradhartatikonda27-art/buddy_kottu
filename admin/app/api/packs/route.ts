import { NextResponse } from 'next/server';
import { SMART_PACKS } from '@/lib/db';

export async function GET() {
  return NextResponse.json({ packs: SMART_PACKS });
}

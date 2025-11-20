import { NextRequest, NextResponse } from 'next/server';
import client from 'prom-client';

// Collect default Node.js metrics
client.collectDefaultMetrics({ prefix: 'invoify_' });

export async function GET(req: NextRequest) {
  const metrics = await client.register.metrics();
  return new NextResponse(metrics, {
    status: 200,
    headers: { 'Content-Type': client.register.contentType },
  });
}
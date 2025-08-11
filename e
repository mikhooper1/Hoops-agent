export async function POST(req) {
  const { message } = await req.json();
  const reply = `Hoops: nice one. You asked: “${message}”. This is a test deployment—I'll be wired to your knowledge base next.`;
  return new Response(reply, { headers: { 'Content-Type': 'text/plain; charset=utf-8' } });
}

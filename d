'use client';
import { useState } from 'react';

export default function EmbedPage() {
  const [input, setInput] = useState('');
  const [msgs, setMsgs] = useState([]);
  const [loading, setLoading] = useState(false);

  async function ask() {
    if (!input.trim()) return;
    const q = input.trim();
    setMsgs(m => [...m, { role:'user', content:q }]);
    setInput('');
    setLoading(true);
    const res = await fetch('/api/ask', {
      method:'POST',
      headers:{'Content-Type':'application/json'},
      body: JSON.stringify({ message:q })
    });
    const text = await res.text();
    setMsgs(m => [...m, { role:'assistant', content:text }]);
    setLoading(false);
  }

  return (
    <div style={{height:'100vh',width:'100vw',display:'flex',flexDirection:'column',fontFamily:'system-ui', background:'#fff'}}>
      <div style={{padding:'12px 16px',borderBottom:'1px solid #eee',fontWeight:600}}>Ask Hoops</div>
      <div style={{flex:1,overflowY:'auto',padding:'12px'}}>
        {msgs.map((m,i)=>(
          <div key={i} style={{textAlign: m.role==='user'?'right':'left', margin:'6px 0'}}>
            <span style={{
              display:'inline-block', padding:'8px 12px', borderRadius:12,
              background: m.role==='user' ? '#e5e7eb' : '#f3f4f6'
            }}>{m.content}</span>
          </div>
        ))}
        {loading && <div style={{color:'#6b7280',fontSize:12}}>Thinking…</div>}
      </div>
      <div style={{padding:12, borderTop:'1px solid #eee', display:'flex', gap:8}}>
        <input
          value={input} onChange={e=>setInput(e.target.value)}
          placeholder="Ask about tackle, cleanout, leadership…"
          style={{flex:1, border:'1px solid #ddd', borderRadius:10, padding:'10px'}}
        />
        <button onClick={ask} style={{padding:'10px 14px', borderRadius:10, border:'none', background:'#000', color:'#fff'}}>
          Send
        </button>
      </div>
    </div>
  );
}

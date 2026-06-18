// Cloudflare Pages Function - POST /api/lead
// Принимает заявку с лендинга (включая сжатые фото) и шлёт письмо через Resend.
// Аналог старого флоу "фото -> письмо на Gmail", но без WordPress.
//
// В Cloudflare Pages -> Settings -> Environment variables задать:
//   RESEND_API_KEY  - ключ API из resend.com (бесплатно: 3000 писем/мес)
//   LEAD_TO         - куда слать заявки, напр. info@moving24.ee
//   LEAD_FROM       - отправитель на верифицированном в Resend домене, напр. "Moving24 <leads@moving24.ee>"
//
// На фронте в window.M24.FORM_ENDPOINT поставить '/api/lead'.

export async function onRequestPost({ request, env }) {
  try {
    const form = await request.formData();
    const get = (k) => (form.get(k) || '').toString().trim();

    const name = get('name'), phone = get('phone'), email = get('email');
    const service = get('service'), msg = get('msg'), pageUrl = get('page_url');

    // honeypot / минимальная валидация
    if (!name && !phone) return json({ ok: false, error: 'empty' }, 400);

    // собрать вложения photo1, photo2, ...
    const attachments = [];
    for (const [key, val] of form.entries()) {
      if (key.indexOf('photo') === 0 && val && typeof val.arrayBuffer === 'function') {
        const buf = new Uint8Array(await val.arrayBuffer());
        let bin = '';
        for (let i = 0; i < buf.length; i++) bin += String.fromCharCode(buf[i]);
        attachments.push({ filename: val.name || (key + '.jpg'), content: btoa(bin) });
      }
    }

    const html =
      '<h2>Новая заявка с лендинга Moving24</h2>' +
      row('Услуга', service) +
      row('Имя / компания', name) +
      row('Телефон', phone) +
      row('Email', email) +
      row('Детали', msg) +
      row('Страница', pageUrl) +
      row('Фото', String(attachments.length));

    const r = await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: {
        'Authorization': 'Bearer ' + env.RESEND_API_KEY,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        from: env.LEAD_FROM,
        to: [env.LEAD_TO],
        reply_to: email || undefined,
        subject: 'Заявка Moving24 - ' + (name || phone || 'без имени'),
        html: html,
        attachments: attachments
      })
    });

    if (!r.ok) {
      const t = await r.text();
      return json({ ok: false, error: t }, 502);
    }
    return json({ ok: true });
  } catch (e) {
    return json({ ok: false, error: String(e) }, 500);
  }
}

// CORS preflight (на случай кросс-доменного хоста формы)
export async function onRequestOptions() {
  return new Response(null, {
    status: 204,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type, Accept'
    }
  });
}

function esc(s) {
  return (s || '').replace(/[<>&]/g, (c) => ({ '<': '&lt;', '>': '&gt;', '&': '&amp;' }[c]));
}
function row(label, val) {
  return '<p style="margin:4px 0"><b>' + esc(label) + ':</b> ' + esc(val) + '</p>';
}
function json(o, status) {
  return new Response(JSON.stringify(o), {
    status: status || 200,
    headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' }
  });
}

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:sm="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:xhtml="http://www.w3.org/1999/xhtml">
<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
<xsl:template match="/">
<html lang="ru">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>Moving24 - XML Sitemap</title>
<style>
:root{--accent:#1a6cd4;--ink:#0e1622;--dim:#5b6b80;--line:#e7edf5;--bg:#f4f7fb}
*{box-sizing:border-box}
body{margin:0;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Helvetica,Arial,sans-serif;color:var(--ink);background:var(--bg);line-height:1.5}
.wrap{max-width:940px;margin:0 auto;padding:34px 18px 64px}
.brand{display:flex;align-items:center;gap:9px;font-weight:800;font-size:20px;letter-spacing:-.02em}
.brand b{color:var(--accent)}
.hd{margin:20px 0 6px;font-size:27px;font-weight:800;letter-spacing:-.025em}
.sub{color:var(--dim);font-size:14.5px;margin:0;max-width:640px}
.count{display:inline-block;margin-top:14px;background:var(--accent);color:#fff;font-weight:700;font-size:13px;padding:6px 13px;border-radius:999px}
.card{margin-top:22px;background:#fff;border:1px solid var(--line);border-radius:16px;overflow:hidden;box-shadow:0 12px 44px rgba(11,15,21,.07)}
table{width:100%;border-collapse:collapse;font-size:14px}
th{text-align:left;background:#fbfdff;color:var(--dim);font-weight:600;font-size:11.5px;text-transform:uppercase;letter-spacing:.05em;padding:13px 16px;border-bottom:1px solid var(--line)}
td{padding:12px 16px;border-bottom:1px solid var(--line);vertical-align:middle}
tr:last-child td{border-bottom:none}
tr:hover td{background:#f6faff}
td.num{color:var(--dim);width:46px;font-variant-numeric:tabular-nums}
a{color:var(--accent);text-decoration:none;word-break:break-all;font-weight:500}
a:hover{text-decoration:underline}
.langs{display:flex;gap:4px;flex-wrap:wrap}
.lng{font-size:10px;font-weight:700;text-transform:uppercase;color:var(--accent);background:rgba(26,108,212,.1);border-radius:5px;padding:2px 6px;letter-spacing:.04em}
.note{margin-top:18px;color:var(--dim);font-size:13px}
.foot{margin-top:24px;color:#9fb0c4;font-size:12.5px}
@media(max-width:560px){.hd{font-size:22px}td,th{padding:10px 11px}.num{display:none}}
</style>
</head>
<body>
<div class="wrap">
  <div class="brand">Moving<b>24</b></div>
  <div class="hd">XML Sitemap</div>
  <p class="sub">Карта сайта для поисковых систем (Google и др.). Все индексируемые страницы со всеми языковыми версиями. Поисковики читают этот файл автоматически.</p>
  <span class="count"><xsl:value-of select="count(sm:urlset/sm:url)"/> страниц</span>
  <div class="card">
    <table>
      <thead><tr><th class="num">#</th><th>Адрес страницы</th><th>Языки</th></tr></thead>
      <tbody>
        <xsl:for-each select="sm:urlset/sm:url">
          <tr>
            <td class="num"><xsl:value-of select="position()"/></td>
            <td><a href="{sm:loc}"><xsl:value-of select="sm:loc"/></a></td>
            <td>
              <div class="langs">
                <xsl:for-each select="xhtml:link[@hreflang!='x-default']">
                  <span class="lng"><xsl:value-of select="@hreflang"/></span>
                </xsl:for-each>
              </div>
            </td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </div>
  <p class="note">Это служебный XML-файл, оформленный для удобного просмотра человеком. Юридические и внутренние страницы намеренно исключены (noindex).</p>
  <div class="foot">Moving24 OÜ</div>
</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>

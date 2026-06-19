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
<title>Moving24 - Карта сайта (XML Sitemap)</title>
<style>
:root{--accent:#1a6cd4;--accent-deep:#1450a8;--ink:#0e1622;--dim:#5d6c80;--faint:#8a98ab;--line:#e8eef6;--bg:#f3f6fb;--card:#fff}
*{box-sizing:border-box}
body{margin:0;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Helvetica,Arial,sans-serif;color:var(--ink);background:var(--bg);line-height:1.5;-webkit-font-smoothing:antialiased}
.wrap{max-width:880px;margin:0 auto;padding:38px 18px 70px}
.brand{display:flex;align-items:center;gap:8px;font-weight:800;font-size:19px;letter-spacing:-.02em}
.brand b{color:var(--accent)}
h1{margin:18px 0 8px;font-size:30px;font-weight:800;letter-spacing:-.03em}
.lede{color:var(--dim);font-size:15px;margin:0;max-width:660px}
.stats{display:flex;gap:8px;flex-wrap:wrap;margin-top:18px}
.chip{display:inline-flex;align-items:center;gap:6px;background:#fff;border:1px solid var(--line);border-radius:999px;padding:7px 14px;font-size:13px;font-weight:600;color:var(--ink);box-shadow:0 2px 8px rgba(11,15,21,.04)}
.chip b{color:var(--accent);font-weight:800}
.sect{margin-top:24px;background:var(--card);border:1px solid var(--line);border-radius:16px;overflow:hidden;box-shadow:0 12px 40px rgba(11,15,21,.06)}
.sect-h{display:flex;align-items:center;gap:10px;padding:14px 20px;border-bottom:1px solid var(--line);background:linear-gradient(180deg,#fbfdff,#f7faff)}
.flag{font-size:19px;line-height:1}
.sect-h .nm{font-weight:800;font-size:15.5px;letter-spacing:-.01em}
.sect-h .cnt{margin-left:auto;font-size:12px;font-weight:700;color:var(--accent);background:rgba(26,108,212,.1);border-radius:999px;padding:3px 10px}
ul{list-style:none;margin:0;padding:0}
li{display:flex;align-items:baseline;gap:10px;padding:11px 20px;border-bottom:1px solid var(--line);transition:background .12s}
li:last-child{border-bottom:none}
li:hover{background:#f6faff}
.dot{flex:none;width:6px;height:6px;border-radius:50%;background:var(--accent);opacity:.55;transform:translateY(-1px)}
a{color:var(--accent);text-decoration:none;font-size:14px;font-weight:500;word-break:break-all}
a:hover{color:var(--accent-deep);text-decoration:underline}
.note{margin-top:22px;color:var(--faint);font-size:12.5px;line-height:1.6}
.foot{margin-top:18px;color:#a7b6c8;font-size:12px;font-weight:600}
@media(max-width:560px){h1{font-size:24px}.wrap{padding:26px 14px 56px}li,.sect-h{padding-left:15px;padding-right:15px}}
</style>
</head>
<body>
<div class="wrap">
  <div class="brand">Moving<b>24</b></div>
  <h1>Карта сайта</h1>
  <p class="lede">XML Sitemap для поисковых систем. Все индексируемые страницы, сгруппированы по языкам. Поисковики (Google и др.) читают этот файл автоматически.</p>
  <div class="stats">
    <span class="chip"><b><xsl:value-of select="count(sm:urlset/sm:url)"/></b> страниц</span>
    <span class="chip"><b>4</b> языка</span>
    <span class="chip"><b>9</b> разделов</span>
  </div>

  <xsl:call-template name="lang">
    <xsl:with-param name="flag" select="'🇪🇪'"/>
    <xsl:with-param name="nm" select="'Eesti (ET)'"/>
    <xsl:with-param name="urls" select="sm:urlset/sm:url[not(contains(sm:loc,'/ru/')) and not(contains(sm:loc,'/en/')) and not(contains(sm:loc,'/fi/'))]"/>
  </xsl:call-template>
  <xsl:call-template name="lang">
    <xsl:with-param name="flag" select="'🇷🇺'"/>
    <xsl:with-param name="nm" select="'Русский (RU)'"/>
    <xsl:with-param name="urls" select="sm:urlset/sm:url[contains(sm:loc,'/ru/')]"/>
  </xsl:call-template>
  <xsl:call-template name="lang">
    <xsl:with-param name="flag" select="'🇬🇧'"/>
    <xsl:with-param name="nm" select="'English (EN)'"/>
    <xsl:with-param name="urls" select="sm:urlset/sm:url[contains(sm:loc,'/en/')]"/>
  </xsl:call-template>
  <xsl:call-template name="lang">
    <xsl:with-param name="flag" select="'🇫🇮'"/>
    <xsl:with-param name="nm" select="'Suomi (FI)'"/>
    <xsl:with-param name="urls" select="sm:urlset/sm:url[contains(sm:loc,'/fi/')]"/>
  </xsl:call-template>

  <p class="note">Это служебный файл <b>sitemap.xml</b>, оформленный для удобного просмотра. У каждой страницы в файле прописаны hreflang-альтернативы на остальные языки + x-default. Юридические страницы и внутренние разделы намеренно исключены из индексации (noindex).</p>
  <div class="foot">Moving24 OÜ</div>
</div>
</body>
</html>
</xsl:template>

<xsl:template name="lang">
  <xsl:param name="flag"/>
  <xsl:param name="nm"/>
  <xsl:param name="urls"/>
  <div class="sect">
    <div class="sect-h">
      <span class="flag"><xsl:value-of select="$flag"/></span>
      <span class="nm"><xsl:value-of select="$nm"/></span>
      <span class="cnt"><xsl:value-of select="count($urls)"/> стр.</span>
    </div>
    <ul>
      <xsl:for-each select="$urls">
        <li><span class="dot"></span><a href="{sm:loc}"><xsl:value-of select="sm:loc"/></a></li>
      </xsl:for-each>
    </ul>
  </div>
</xsl:template>

</xsl:stylesheet>

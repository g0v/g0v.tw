---
layout: default
title: 網站地圖
id: sitemap
---
<ul>
{% for page in site.pages %}
<li>
<a href="{{ page.url | remove: 'index.html' }}">
{% if page.title %}
{{ page.title }}
{% else %}
{{ page.url }}
{% endif %}
</a>
</li>
{% endfor %}
</ul>

---
layout: default
---

This is a list of projects that this site documents. If you're looking
for tutorials for each one, you'll find links below. If you're looking
for a "more professional" presentation of this information, plus my
other credentials, you should look at [this auto-generated CV
page](TODO).

# Projects

{% for page in site.pages %}

{% if page.cvinfo %}
{{ page.title }}
{% endif %}

{% endfor %}

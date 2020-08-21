---
layout: default
---

This is a list of projects that this site documents. If you're looking
for tutorials for each one, you'll find links below as they get added.
If you're looking for my professional presentation of this information
(plus other credentials) you can take a look at [this auto-generated CV
page](/cv).

# Projects

{% for page in site.pages %}

{% if page.cvinfo %}
{{ page.title }}
{% endif %}

{% endfor %}

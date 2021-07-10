---
layout: default
---

My PhD funding came from teaching assistantships, which meant that I was
a TA every quarter in grad school. Consequently, I have a variety of
courses under my belt.

In rough order of relevance.

{% for teach in site.data.teaching %}

## {{ teach.title }}

<small class="gray">{% if teach.instructor %}
alongside {{ teach.instructor }}
{% else %}
taught by me
{% endif %}</small> <big>|</big> <small class="gray">{{ teach.season }}
{{ teach.years | join: ", " }}
</small>

{{ teach.desc }}

{% if teach.talks %}
### Lectures & Talks

{% for talk in teach.talks %}
{% if talk.link %}
    {% assign link = talk.link %}
{% else if talk.external_link %}
{% else %}
    {% assign link = talk.title | replace: " ", "_" | append: ".pdf" %}
{% endif %}

{% if talk.external_link %}
- [{{ talk.title }}]({{ talk.external_link }})
{% else %}
- [{{ talk.title }}](/files/talks/{{ link }})
{% endif %}
{% endfor %}
{% endif %}

{% endfor %}

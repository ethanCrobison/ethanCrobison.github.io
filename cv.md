---
layout: default
---

# Profile

- Ethan Robison
- 312 502 9032
- ethanrobison@protonmail.com
- Chicago, IL

# Education
- MS in Computer Science, Northwestern University, 2020
- BS in Computer Science, Northwestern University, 2016

# Core Skills
- languages/toolsets: C#, git, Unix command line, zsh/bash
- software: Unity3D, Microsoft Visual Studio, LaTeX, vim
- conceptual: game design and programming, symbolic AI (artificial
  intelligence), data structures, automation, research
- interpersonal skills: management, mentoring, computer science
  education
- foreign languages: English (native speaker), Spanish (professional
  fluency), French (familiar)

{% assign cvitems = site.pages | where_exp: "info", "info.cvinfo" %}

{% for type in site.data.cvcategories.types %}

---

# {{ type.title }}

{% assign items = cvitems | where: "cvinfo.type", type.name %}
{% for item in items %}
{% assign info = item.cvinfo %}
## {{ item.title }}

<span class="gray">
{{ info.org }}---{{ info.time }}{% if info.extra %}{% for e in info.extra %}---{{ e }}{% endfor %}{% endif %}
</span>

{{ info.blurb }}

[Project page.]({{ item.url }})

{% endfor %}
{% else %}
<!-- Nothing here! -->
{% endfor %}

<!-- TODO teaching -->
<!-- TODO hobbies and interests -->

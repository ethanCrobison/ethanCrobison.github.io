---
layout: home
title: ethanrobison
---

{% capture contact %}
<a href="mailto:{{ site.email }}">{{ site.email }}</a><br>
<a href="https://github.com/{{ site.github_username }}">
github.com/{{ site.github_username }}
</a>
{% endcapture %}

{% capture links %}
<p>I study experimental game AI. I make things. Explore to find my:</p>

<ul>
<li><a href="/posts">blog</a></li>
<!-- - [work experience](/projects/professional) -->
<li><a href="/teaching/teaching">teaching experience</a></li>
<!-- - projects/CV -->
<!-- - [research](/research) -->
<li><a href="/cv">CV</a></li>
<li><a href="/projects/landing">projects</a></li>
<li><a href="/tutorials/intro">tutorials</a></li>
<li><a href="/principles">site principles</a></li>
</ul>
{% endcapture %}

{% include card.html cover=page.title contents=contact %}
{% include card.html cover="explore" contents=links %}


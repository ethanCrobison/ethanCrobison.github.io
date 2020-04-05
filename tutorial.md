---
layout: default
title: Tutorials
---

<!-- TODO get these from a data file -->

# Game Programming in Unity

This is some text.

{% for tut in site.tutorials %}
[{{ tut.title | escape }}]({{ tut.url }})
{% endfor %}

<br>
{% for proj in site.data.projects %}
# {{proj.link}}
{% endfor %}

This is some more text.

- start menu
- character info
- hover preview
- mouseovers
- camera tracking
- p-controllers

<!--

# Text Editing

[TK]

# Vim

[TK]

# Shell Scripting

[TK]

# Answer Set Programming

[TK]

# Web Development

[TK]

-->

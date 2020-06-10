---
layout: home
title: ethanrobison
---

{% capture contact %}
<a href="mailto:{{ site.email }}">{{ site.email }}</a><br>
<a href="https://github.com/{{ site.github_username }}">
github.com/{{ site.github_username }}
</a>

<p>I forge software and I tell stories. I teach subjects worldly and
ethereal. I am an explorer of the vast possibility spaces of procedural
lands, and I make maps of what I find and learn.</p>

{% endcapture %}

{% capture crafts %}
<p>The services I offer are world-class.</p>

<div class="category"><b><em>Software of all kinds.</em></b> Games,
websites, desktop applications, scripts for automating menial tasks, &
more. See <a href="TODO">my portfolio</a> for demonstrations.</div>

<div class="category"><b><em>Individual tutoring and teaching in the
realm of computer science.</em></b> I've been teaching CS since I was an
undergrad. See <a href="TODO">what my past students have said.</a></div>

<div class="category"><b><em>Voice overs, voice acting, and
narration.</em></b> I didn't earn the nickname "The Voice" for nothing.
Listen to <a href="TODO">some samples.</a> </div>

<div class="category"><b><em>Private group GMing for select
TTRPGs.</em></b> I'm a master storyteller in the fantastic worlds of
DnD5e, Call of Cthulhu, Nights Black Agents, and Fall of Delta Green, to
name but a few. New systems can be adopted upon reasonable
request.</div>

{% endcapture %}

{% capture stories %}
<p>If, instead, you've come to be entertained, gather 'round the
fire.</p>

<div class="category"><b><em>Rantings and ravings.</em></b> <a
href="TODO">My podcast, "Eldritch Radio".</a> Fed into your ears, bidden
or not, every Wednesday at 8PM CT.</div>

<div class="category"><b><em>Journeys into procedural lands.</em></b> My
graduate research led me down the arcande paths of procedurally
generated stories and places.  See them brought to life. Better yet, <a
href="TODO">explore them with me.</a></div>

<div class="category"><b><em>Scribblings.</em></b> My blog, my blog.
Tours of automation, procedural content generation, and more. <a
href="TODO">Read the latest.</a></div>

<div class="category"><b><em>Miscellaneous entertainments.</em></b> For
everything else, whatsoever it may be that occupies my time and
energies. <a href="TODO">Dive in.</a></div>
{% endcapture %}

{% include card.html cover="me" contents=contact %}
{% include card.html cover="crafts" contents=crafts %}
{% include card.html cover="stories" contents=stories %}

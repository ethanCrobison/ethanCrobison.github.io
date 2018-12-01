---
layout: page
title: "clingo notes"
permalink: /clingo/
---

This is a collection of notes on the answer set programming system Clingo. Clingo is
notoriously... esoteric. These are the gotchas that I've noticed over my time learning
about the system.

The notes are broken up into a couple of random sections right now. Each hint includes a
description of where/how I found out about it.

---

## Clingo from the Command line

#### Run `clingo --help=3` to see all of your options
If you run `clingo --help` expecting to find all of the options for the system, you'll
be sad. If you want to see _everything_, run `clingo --help=3` instead.

__Source:__ running `clingo --help`, in the "Basic Options" section:
```
  --help[=<n>],-h         : Print {1=basic|2=more|3=full} help and exit
```

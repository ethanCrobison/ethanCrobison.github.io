---
layout: post
title: "Citations in Pandoc"
date: 2018-11-29
categories: pandoc papers
---

Here's a handy code snippet for you Pandoc lovers (if you're not a Pandoc lover, maybe
this will get you on the train):

```zsh
pandoc --filter pandoc-citeproc --bibliography=bibliography.bib \
-s paper.md -o paper.pdf
```

If you want two column format, you can add `--variable classoption=twocolumn`.

### An Example

```markdown
<!--paper.md-->
---
author: Dr. Henry Armitage
title: Spin-wave dynamics in a hexagonal 2-d magnonic crystal
---

```

---
layout: post
date: 2018-11-29
title: "Pandoc Basics"
categories: pandoc tutorial
---

I love [Pandoc](http://pandoc.org). Ever since my friend Slim told me about it (and I
actually started using it) I have been enthralled with how slick it is and the fact that
it _just works_. Most anything that you throw at Pandoc, it can handle.

Let's get down to brass tacks (this will be a catchphrase).

I'm working under the assumption that you have __both__ Pandoc and Pandoc Citeproc
installed. They're availabe on `homebrew` and a goodly chunk of package managers. You'll
also need a LaTeX output. Go to
[http://pandoc.org/installing.html](http://pandoc.org/installing.html) instead of taking
my advice.

## The Very Basics

Given some markdown file:

```markdown
<!--example.md-->

# This is a markdown file!

> It has all the things you care to include.

$\frac{1}{2}$ but it also has $x_1$ some math.

```

You can turn it into a .pdf like so:

```zsh
pandoc -s example.md -o example.pdf
```

Your example.pdf will look like this:

![An example compiled pdf](/files/images/pandocexample.png "An example compiled pdf")


## Citations

## Variables

## Example Makefile

Here's an example makefile for a pandoc project involving 

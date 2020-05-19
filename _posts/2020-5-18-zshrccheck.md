---
layout: post
categories: automation
date: 2020-5-18
title: "Quick-and-dirty Validation with Grep"
---

I've published a [line-by-line walkthrough of the .zsrhc that I use][1].
Initially, that page's markdown included the line (in [Liquid][2]):

```liquid-markdown
{% raw %}
{% include zshrc %}
{% endraw %}
```

Where `zshrc` was linked linked to my `_includes` directory:

```
ln ~/PATH/TO/.zshrc _includes/zshrc
```

Then, I would copy the file's contents over line-by-line and annotate
them as needed. The problem with this method is that any changes to my
`.zshrc` would be automatically applied to the page's contents, but I
might forget to update the annotations!

Since one of the points of programming is to use computers to do what
humans are bad at, here's a script that double-checks my work:

```zsh
#!/bin/zsh

original=$1
lineby=$2

< $original while read x; do
    if [[ -z $x ]]; then continue; fi # empty line
    if rg --quiet -x "^\s*#.*$" <<< $x; then continue; fi # comment
    if ! rg --quiet -F $x $lineby; then echo $x; fi
done
```

I can call this with, e.g.:

```
./_checklinebyline ~/.zshrc ./zshrc.md
```

And every non-empty, non-comment line in my `.zshrc` is searched for
usng [ripgrep][3] in the line-by-line annotation. If doesn't show up, it
gets printed out.

A neat way to check my work. Next step will be making sure that this
script gets run on all of my line-by-lines automatically (validation is
no good if you don't run it!).

## Coda: Shellscripting Weirdness

A couple of useful things from this script, for beginner/intermediate
shell programmers.

The construction `< $file while read x` is the "correct" replacement for
the so-called "Useless Use of Cat" ([UUOC][4]) I might have done a few
months ago: `cat $file | while read x`.

```zsh
    < $file while read x; do # this
    cat $file | while read x; do # over this
```

The construction `<<< $x` is the avoids a "Useless Use of Echo"
([UUOE][5]) that I have definitely done in the past: `echo $x | rg ...`.

```zsh
    rg ... <<< $x # this
    echo $x | rg ... # over this
```

<br>

Using `<` for input and `<<<` (called a [herestring][6]) look a little
wonky, but if there's one thing that shell scripting is good for, it's
making you feel like a wizard learning an esoteric magical language.

[1]: /tutorials/zshrc
[2]: https://shopify.github.io/liquid/
[3]: https://github.com/BurntSushi/ripgrep
[4]: http://porkmail.org/era/unix/award.html#cat
[5]: http://porkmail.org/era/unix/award.html#echo
[6]: https://unix.stackexchange.com/questions/59007/echo-vs-or-useless-use-of-echo-in-bash-award

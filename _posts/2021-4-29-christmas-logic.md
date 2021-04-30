---
layout: post
author: ethan
title: "Answer Set Programming? For Breakfast?"
date: 2021-04-29
---

Two Christmases ago,[^1] the circle of people involved in
gift-giving/receiving expanded to the point where the pairwise giving of
gifts became unwieldy. My mother and I separately concocted the plan to
have folx each draw names randomly, then give a solitary gift to the
person whose name they drew. This worked out nicely for one year, when
there were six of us in the pool. Then, my brother got married, and my
other brother got a serious partner, and the pool of people expanded,
but also several constraints were added:

- R had a gift for L already, so they needed to be assigned L
- E had a gift for R already, so they needed to be assigned R
- R and N couldn't have each other (partners)
- M and T couldn't have each other (partners)
- H couldn't have E (same as last year and repetition was out of the
  question)

My mom had attempted to shuffle cards together and pair them up, but the
increased number of people and the additional constraints made
assignment excrutiating.

Enough context, on to the solution! Answer set programming was designed
for stupid situations like this!

First, an enumeration of all the people:

```ansprolog
p(q).
p(m).
p(t).
p(r).
p(l).
p(e).
p(n).
p(h).
```

Next, a definition of gifting that looks something like `gift(X,Y)`
means that `X` has been assigned `Y` as their recipient. In ansprolog,
we do this with a couple of rules:

```ansprolog
1 { gift((X, Y)) : p(X), p(Y), X != Y } 1 :- p(X).
```

**Meaning**: For every `X` where `p(X)` (for every person), make it such
that there is exactly one `gift((X, _))` statement, meaning that `X` is
giving a gift to exactly one person. Also, note `X != Y` means you can't
gift yourself.

```ansprolog
1 { gift((X,Y)): p(X), p(Y), X != Y } 1 :- p(Y).
```

**Meaning**: Like above, but note that this makes every person
_receive_ a gift from exactly one other person. If you don't do this,
everyone will give exactly one gift, but one person will likely receive
the rest of them.

```ansprolog
:- gift((X,Y)), gift((Y,X)).
```

**Meaning**: Don't allow two people to gift each other. Life's more fun
that way. The ansprolog-y way to read this is to think of "bottom is
proven if the thing on the otherside of the turnstyle is true." One must
never prove bottom! Never allow the righthand side to be true. 

With these three rules (and the above `p` definitions), we can get a
valid gift distribution:

```
clingo christmas.lp

Reading from christmas.lp
Solving...
Answer: 1
p(q) p(m) p(t) p(r) p(l) p(e) p(n) p(h) gift((q,t)) gift((r,q))
gift((m,r)) gift((l,m)) gift((t,e)) gift((n,l)) gift((e,h)) gift((h,n))
SATISFIABLE
```

But our output is a little messy! How about a:

```ansprolog
#show.
#show X : gift(X).
```

**Meaning**: `#show.` says, "don't print anything I don't explicitly ask for.
`#show X : gift(X)` (read "show `X`, where `gift(X)` is true) prints all
`X` from inside `gift(X)` that the system could prove. This is the
reason that we made our definition `gift((X, Y))` instead of `gift(X,
Y)`; making it a monadic statement with a tuple inside is easier for
printing!

```
clingo christmas.lp

Reading from christmas.lp
Solving...
Answer: 1
(q,t) (r,q) (m,r) (l,m) (t,e) (n,l) (e,h) (h,n)
SATISFIABLE
```

Much more readable! Let's add the more straightforward constraints we
set out above (forcing certain people to have each other, or not):

```ansprolog
gift((e, r)).
gift((r, l)).
:- gift((r, n)).
:- gift((n, r)).
:- gift((m, t)).
:- gift((t, m)).
:- gift((h, e)).
```

**Meaning**: the first two statements force e to gift r, and r to gift
l. The remaining statements prevent the various couples/unwanted
pairings.

```
clingo christmas.lp

Reading from christmas.lp
Solving...
Answer: 1
(e,r) (r,l) (q,t) (l,q) (m,e) (n,m) (t,h) (h,n)
SATISFIABLE
```

Now, I just need to send this to my mom! Sadly, this output won't do.
Let's do a quick shell trick. First, let's make the output nicer to play
with:

```
clingo christmas.lp --outf=2

{
  "Call": [
...
    {
      "Witnesses": [
        {
          "Value": [
            "(e,r)", "(r,l)", "(q,t)", "(l,q)", "(m,e)", "(n,m)",
"(t,h)", "(h,n)"
          ]
        }
      ]
    }
  ],
...
}

```

This makes the output json, so we can now parse it was `jq`, a handy
json command line tool that I use frequently. We can snag the parts we
care about:

```
clingo christmas.lp --outf=2 | jq ".Call[0].Witnesses[0].Value"

[
  "(e,r)",
  "(r,l)",
  "(q,t)",
  "(l,q)",
  "(m,e)",
  "(n,m)",
  "(t,h)",
  "(h,n)"
]
```

Trim this up with `head` and `tail`:

```
clingo christmas.lp --outf=2 | jq ".Call[0].Witnesses[0].Value" | head
-n -1 | tail -n +2

  "(e,r)",
  "(r,l)",
  "(q,t)",
  "(l,q)",
  "(m,e)",
  "(n,m)",
  "(t,h)",
  "(h,n)"
```

And loop over it to get the parts we care about with `rg` and subsitute
using zsh:

```
clingo christmas.lp --outf=2 | jq ".Call[0].Witnesses[0].Value" | head
-n -1 | tail -n +2 | while read x; do y=$(rg -o "[a-z]+,[a-z]+" <<< $x);
echo "${y/,/ has }"; done

e has r
r has l
q has t
l has q
m has e
n has m
t has h
h has n
```

Et, voila! A mother-approved format for assignment. And that, kids, is
how answer set programming saved Christmas.

## Appendix

The whole program.

```ansprolog
p(q).
p(m).
p(t).
p(r).
p(l).
p(e).
p(n).
p(h).

1 { gift((X, Y)) : p(X), p(Y), X != Y } 1 :- p(X).
1 { gift((X,Y)): p(X), p(Y), X != Y } 1 :- p(Y).
:- gift((X,Y)), gift((Y,X)).

gift((e, r)).
gift((r, l)).
:- gift((r, n)).
:- gift((n, r)).
:- gift((m, t)).
:- gift((t, m)).

:- gift((h, e)).

#show.
#show X : gift(X).
```

---

[^1]:
    It's Spring 2021, so Christmas of 2019. "Last Christmas" should
    _probably_ refer to Christmas X-1, where X is the year, right?
    Therefore, "two Christmases ago" means Christmas X-2, right? The
    debate rages on.

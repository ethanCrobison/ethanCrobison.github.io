---
layout: post
title: "Parsing Arkham Horror Cards Using Prolog: Part 1"
author: Ethan
date: 2021-5-11
---

In the last post, I outlined the major goal of this project: can we
write something that helps us understand if we can use Scavenging on Old
Keyring? What about Grisly Totem (3) and Take Heart? There are a lot of
steps that we have take before we're even ready to _parse_ those cards,
let alone to plug them into a model of skill tests and the rest of the
game.

To keep things simple, I started with (partial) models of four Core Set
_Events_[^1]:

- [Emergency Cache (0)](https://arkhamdb.com/card/01088)
- [Hot Streak (4)](https://arkhamdb.com/card/01057)
- [Working a Hunch](https://arkhamdb.com/card/01037)
- [Evidence (0)](https://arkhamdb.com/card/01022)

I chose **Events** instead of  **Assets**, because the latter require
some sort of model of the abstract space in which the game takes place
to really make sense. And they so often give you passive bonuses, or
rely on in-game triggers to be interesting. I chose **Events** over
**Skills** because the latter requires a model of skill tests, and I'm
not there yet. (I don't even have _locations_ represented, let alone
tests.) I chose **Events** because, as I tell all the new players I'm
teaching the game, (most) **Events** are their own, self-contained
little card: you play them, and they do the thing they say. Emergency
Cache? Here's 3 resources. Discard it now. You're done. Working a Hunch?
Here's your clue. See ya.

And I chose these four for similar motivations of straightforwardness:

1. Emergency Cache is the simplest event in the game. Even when I get
   around to actions, costs, Attacks of Opportunity, etc., it's going to
continue to be the simplest event in the game.
2. Hot Streak is slightly more complicated Emergency Cache.
3. Working a Hunch introduces _Fast_ and "Play only during your turn,"
   but otherwise involves moving a token into your token pool much like
Emergency Cache.
4. Evidence is like Working a Hunch in that it's fast and gets you
   clue(s), only now it has a triggering effect.

In other words, the four build off of one another. They deal with
tokens, which are not nearly as complicated as decks. They don't involve
the keyword _Choose_, or any of the keywords **Fight**, **Evade**,
**Resign**, etc. They don't mention the encounter deck. And so on.

# Results

So, let's do a demonstration. Running `swipl --traditional
arkham.prolog` gives us a prompt:[^2]

```prolog
arkham_main: ?-
```

And the magic query is `card(?Keywords, ?Effects, +CardText, [])`.[^3]
For example:

```prolog
?- card(K, E, "gain 3 resources.", []).
K = [],
E = [effect(increase, 3, pool(resource, you))].
```

We can also do Hot Streak:

```prolog
?- card(K, E, "gain 10 resources.", []).
K = [],
E = [effect(increase, 10, pool(resource, you))].
```

Or even a hypothetical card that only gives us 1 resource:

```prolog
?- card(K, E, "gain 1 resources.", []).
false.
```

Ah, yes, I forgot to mention, it's important to match count. If you want
to gain 1 resource, you can't say "1 resources." If I were writing this
to parse user input or custom cards, I'd be much more generous. But I'm
trying to correctly handle Fantasy Flight's professionally-produced card
text, so I try to be a stickler.[^4]

Next, let's look at our two _Fast_ cards:

```prolog
?- card(K,
        E,
        "fast. play only during your turn.\n discover 1 clue at your location.",
        []).
K = [keywords(fast, window(during(your_turn)))],
E = [effect(increase, 1, pool(clue, you)),
     effect(decrease, 1, pool(clue, location))].
```

And:

```prolog
?- card(K,
        E,
        "fast. play when you defeat an enemy.\n discover 1 clue at your location.",
        []).
K = [keywords(fast, window(after(you_defeat_enemy)))],
E = [effect(increase, 1, pool(clue, you)),
     effect(decrease, 1, pool(clue, location))].
```

The plan is to use these "abstract syntax trees" of card effects as part
of the guts of a model of the game. Whether that's in pure Prolog or as
part of Unity project is still tbd.

# Next Steps

I think I'd like to get two key mechanic working for the next leg of
this project: locations and basic investigate actions. Until I have a
model of who's where on the board, it's going to be tricky to make much
forward progress. Locations might suggest a user interface for seeing
what's where, and for looking at the results of running the prolog
backend, but we'll see about that. And I need to start with one of the
basic actions, and I've already got a rough model of the clue token
pools already, so hopefully it's a natural fit.

In terms of cards, I'd like to shift my focus to two skills (and maybe
some others):[^5]

- [Deduction (0)](https://arkhamdb.com/card/01039)
- [Perception (0)](https://arkhamdb.com/card/01090)

Both are relevant to investigation, and both have an "if this test is
successful," which takes us in the direction of forming a skill test
timing windows model. Until next time.

Code for this project can be found on [my
github]({{site.github_base}}{{site.github_username}}/arkham_parse)

[^2]:
    The `--traditional` flag affects, among other things, how strings
    are interpreted. In this case, it treats them as a `list` of 
    character codes. I tried setting the flags inside of the files, but
    got such inconsistent results that I gave up and used
    `--traditional`. I did this so that I could write Prolog DCG
    rules that handled `"things in quotes"` instead of having to
    tokenize the text myself. It just made it much easier.

[^1]:
    All card links from [ArkhamDB](https://arkhamdb.com/). Accessed
    5-11-2021.

[^3]:
    The extra `[]` is related to the special DCG rules in Prolog, and
    just tells the query that this is the whole string we want to parse.

[^4]:
    Not that they don't have they're own errata now and then. Looking at
    you, Winchester.

[^5]:
    All card links from [ArkhamDB](https://arkhamdb.com/). Accessed
    5-11-2021.

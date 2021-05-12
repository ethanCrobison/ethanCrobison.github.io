---
layout: post
title: "Parsing Arkham Horror Cards Using Prolog: Part 0"
author: Ethan
date: 2021-5-11
---

# Motivation

Arkham Horror: The Card Game is probably my favorite game. It's
certainly my favorite (mostly) physical game. It's produced by Fantasy
Flight, under the excellent design leadership of MJ Newman. The
principal mechanic of the game resolves around performing skill tests:
an investigator (player character) compares their skill, plus modifiers,
against a threshold. If the resulting number is greater than or equal to
the threshold, they pass the test and get some good results.

Of course, it's a little more complicated than that. There are many
confounding factors (in particular, randomness in the form of a variable
bag of modifiers printed on tokens offers the game's most flexible
design space), but this project kicked off with an especially hairy one.
Here's an excerpt from the rules outlining "Skill Test Timing":[^1]

![Skill Test Timing](/files/images/arkham_horror_skill_test_timing.png)

We direct our attention to two parts: **ST. 6 Determine success/failure
of skill test.** and **ST. 7 Apply skill test results.** And then we
direct our attention at two cards (among many):
[Scavenging](https://arkhamdb.com/card/01073), and [Old
Keyring](https://arkhamdb.com/card/60507) whose usages depend on
understanding these timing windows quite thoroughly.[^2] Both are also
heavily intertwined with a broad skill test category called
**Investigating.** Scavenging reads:

> **[reaction]** After you successfully investigate by 2 or more,
> exhaust Scavenging: Choose an **[[Item]]** card in your discard pile
> and add it to your hand.

Old Keyring reads:

> Uses (2 keys). If there are no keys on Old Keyring, discard
> it.\n**[action]**: **Investigate.** Your location gets -2 shroud for
> this investigation. If you succeed, remove 1 key from Old Keyring.

We care about two things in particular. First, about Old Keyring's "If
there are no keys...  discard it." Which happens because of the same
card's "If you succeed, remove 1 key..." In other words, "If you
succeed," "[Maybe] discard Old Keyring." Second, we care about
Scavenging's "After you successfully investigate... choose [a card] in
your discard pile and add it to your hand."

These interact with one another, clearly. But it's not so simple as it
may first appear.

# A Conundrum

A pop quiz, which may be impossible if you aren't familiar with Arkham
Horror: can you use Scavenging to take Old Keyring back from the discard
pile on the same turn that Old Keyring discards itself from running out
of uses? What if I told you that, in general, the order of resolution
for the various timing words "when" "if" and "after", is roughly the
respective order of those three?

The answer is that you may not, because Scavenging says "...after you
successfully investigate," which is determined during **ST. 6.** You
have "successfully" done the test. Old Keyring discards itself when it
has no keys, and it (potentially) loses a key during **ST. 7,** per "if
you succeed." Think of "if you succeed" as adding a consequence to the
list of things that happen when you succeed at a given test.

You shouldn't feel bad if you didn't get the answer. Without an FAQ (of
which the game has many), it's not clear that any reasonable person
could argue the correct way definitively. After all, a reading of the
cards could certainly suggest that "successfully investigating" and "if
you succeed [at this investigation]" happen at the same time. But they
don't. It's just in the rules.

Okay, that's pretty confusing, but what am I getting at here? I had
three ingredients, two of which are apparent:

1. A complex series of rules on orders of operation, with fairly rigid
   (albeit hard to parse) interpretations.
2. A set of cards with these rules written in that bizarre mixture of
   formal and natural language unique to rules descriptions.
3. A penchant for programming in Prolog, a language invented (at least
   in part) for natural language processing.

So, my question was simple: can one write a tool to parse Arkham Horror:
The Card Game cards such that it provides a (mostly) canonical
interpretation of the various results of certain card effects?

The answer: yes. But I had planned on outlining evidence to that fact in
_this_ post, and instead I wrote 700+ words of motivation. Stay tuned
for part... 1 of the series, in which I explain just how I got this
dirigible off the ground.

[^1]:
    Image captured from .pdf downloaded from [The FFG
      Website](https://www.fantasyflightgames.com/ffg_content/Arkham_Horror/DH_rules_english.pdf),
    accessed 05-11-2021.

[^2]:
    Both cards linked from [Arkham DB](https://arkhamdb.com/), accessed
    05-11-2021.

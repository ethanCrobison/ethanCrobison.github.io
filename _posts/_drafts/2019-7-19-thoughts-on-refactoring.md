---
layout: post
title: "Thoughts on Refactoring Code"
date: 2019-7-19
categories: thoughts 
---

I refactored code today. I took a monolithic file and made it... slightly less
monolithic.

```
cat Game/Assets/Code/Session/Sim/Trackers/PeopleTracker.cs | wc -l >>> 736
```
```
cat Game/Assets/Code/Session/Sim/Trackers/PeopleTracker.cs | wc -l >>> 374
cat Game/Assets/Code/Session/Sim/Trackers/PersonCreator.cs | wc -l >>> 328
```

The eagle-eyed among you may notice that 374 + 328 = 702, which is ultimately not that
much smaller than 736. In fact,

So what _did_ I do? Why bother refactoring? First, let's talk about reducing SLOC. Then,
let's talk about the abstract changes...

Gotta try to write this blog in a classic style.

Ceterus paribus, a shorter program is a better one. You cannot have an error in a line of
code that isn't there, and you cannot miss a bug in a screen that you can't scroll to.

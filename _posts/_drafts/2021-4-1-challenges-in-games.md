---
layout: post
categories: games
date: 2021-4-1
title: "Two Kinds of Challenges for AI in Games"
---

There are, generally, two kinds of challenges in games. The first is a
matter of deducing what to do: the current game state either has a clear
goal apparent from it and an unclear path to get there, or perhaps the
goal is itself unclear and getting there is a separate challenge from
even figuring out what one is working towards. The second kind of
challenge is one of execution: given a particular state, and a
particular goal, the player is left asking, "am I able to get there?"

These two challenges are not mutually exclusive; indeed, they are two
axes along which games of all varieties exist. Many masterfully designed
games have a principal form of challenge, but take a few detours into
the space carved out by the other. Dark Souls, which is primarily a game
which challenges its players on the execution side of things, does
occasionally present so called "puzzle" bosses, which have some gimmick
that prevents the player from approaching them like the other bosses in
the game. One's sword is useless, say, and so the player is left
scouring the arena for the doohickey to push, or the magic protection
stone to break, or so on.

Similarly, puzzle games such as Sokoban are, in terms of execution,
trivial. The inputs require no specific timing or reflex, and the game
state is perfectly explicit. The player has perfect information at all
times. Nevertheless, figuring out a thorny Sokoban puzzle is a matter of
great computational effort (or, more often, a combination of thinking
and the wonderful "undo" and "reset" functionalities). This sort of
computational complexity is outlined in excellent detail in Costikyan's
_Uncertainty in Games_ [TODO CITE]. In fact, Costikyan's piece is much
more comprehensive than this one will be in terms of the broad ways in
which a game can offer the player a tough nut to crack. This is not,
however, a discussion of games in general (though I assert that my
sweeping claim of two axes of challenge is a fairly interesting lens
through which to consider games writ large).

Instead, I want to address the lack of challenges in the "what am I
supposed to do?" category vis-a-vis complex game AI. I posit that, in
general, advances in game AI have hitherto been concerned with providing
the player with interesting challenges in execution rather than
challenges in perception. For example, in _The Last of Us_, the search
behavior presents the player with a number of hostile NPCs navigating
the world, and conveniently offers them a number of exposed backs to
sneak up on and perform stealth kills unto. Advancements made between
_TLOU_ and _TLOU Part 2_ to the various behavior systems: changes to the
way in which search was performed, additional voiceover lines and
knowledge representation markup indicating such details as, e.g., "I
think [the player] is in this building," etc. provide the player with a
more rich and tangible sense of the game's diegesis. _But_, they don't
offer the player a greater challenge in figuring out what the agents in
the game are doing; in fact, much of the work works to surface more
thoroughly the inner workings of the agents' internal state. In a
certain sense, there was a corresponding increase in information
provided to the player alongside an increase in agent processing. The
end result is that the player's difficulty in executing the game's
central challenge (doing a lot of murders) was richer, and also more
intense. After all, the agents could perform more "realistic" search and
other tactical behaviors, since the player was given richer information.
It's worth thinking about what the game would have looked like without
more information: smarter agents without more information likely just
means a worse time for the player. Putting it differently, if you want
to make the agents behave smarter, you have to find a way to offset the
increased challenge this will give players. This is all well and good,
but it elides addressing an earlier point—what about challenges of "what
do I do now?"

Challenges of "what do I do now?" are, generally speaking, puzzles.
Point-and-click adventure games, sliding tile puzzles, and the quaint
"riddles" of Skyrim dungeons all fall under this category. The player
must figure out what to do next, and only then can they go forth and
execute. Usually, the space of possible actions is large enough that
brute forcing the challenge is tedious, although in some cases (Skyrim
"riddles", for example) an exhaustive search is possible. But what of
AI? Puzzles immediately bring to mind the clockwork AI of, say, stealth
games such as the Metal Gear Solid series, but these are in fact
primarily instances of the execution variety of challenges: agents
behave predictably enough that the player's task isn't to figure out
what agents are going to do but rather to weave their way through the
space of behavior the agents exhibit. No, I'm talking about agents whose
behavior space is sufficiently large that the player needs to form a
mental model for how an agent will act when the game state has changed
in some particular way, and where that change is more substantial than
just a whole bunch of markup for commenting on open doors and such.

Games that have attempted rich behavior systems, wherein the player's
job is to figure out what to do next in interaction with the agents, are
typically of the "experimental AI in games" variety. Some notable
exceptions include, say, Black & White, or Dwarf Fortress, arguably
(perhaps not, though; DF is a great example of a great conglomeration of
details, but meaningfully predicting the agents' behavior is borderline
impossible, and so the result is a pleasant sort of chaos, like waves
crashing over a beach, if those waves were blood and carried the corpses
of thousands of mutilated goblins). But I shall provide a fairly
representative list now:

- MKULTRA
- Façade
- Prom Week
- Versu
- Black & White
- Bad News (in a sense)
- ????

There are others, presumably, but this list will suffice to demonstrate
the sorts of different difficulties this sort of game has. By "this sort
of game" I mean, a game which has as its principal challenge one of
"what do I do now?" where that challenge stems from a sufficiently rich
behavior space for the agents within it, such that the player's primary
job from moment to moment is making predictions about how their actions
will change the actions of the various agents throughout the game.

Let us take Prom Week as an example. At first blush the "social physics"
of the game seems straightforward: be nice to people, and they will like
you; be spiteful and they will resent you, and so on. The creators of
the game did an excellent job of capturing a core of social norms that
really does feel fairly representative of how people think about others'
actions. The challenges are twofold. The first is one of complexity, on
the knowledge representation side. The creators did perhaps _too_ good
of a job modeling high school social interactions, and the result is
that things such as, "X likes calculators, which are nerdy, so when X
talks to Y about THINGS X LIKES, Y is offput by the discussion." This
makes sense to a degree: gushing about graphing calculators is probably
not the most reliable way to make friends in the long run (sorry to the
TI-84 lovers in the audience). But there is a conflict of reasoning
here. If the player thinks, "I shouldn't have X talk to Y about
calculators; they'll dislike X for being a dork," then the player will
have guessed correctly. However, if they instead think, "I want Y to
like X; sharing one's interests is a good way to make friends," (a not
unreasonable assumption, either, depending on the social context) they
will find their efforts backfiring.

This leads into the next challenge that Prom Week has: in an effort to
maintain the game's diegesis, the player cannot simply "undo" a social
gaff; instead, they must live with their embarrassment, in much the way
that a real life high schooler who shares too freely their love of Texas
Instruments must, as well. Presumably this is to keep the game
"gamelike"; if the player can reroll any bad social maneuvers like a
Sokoban player rolling back a move, they will inevitably greedily search
their way to victory. On top of that, however, this is because puzzle
games like Sokoban and "puzzle" games like Prom Week hold different
weights in the minds of players. In Sokoban, the various pieces are
crates or some analog: lifeless freight to be roughed into place. In
Prom Week, however, the rigid bodies of the boxes are replaced with the
soft bodies of jockses and gothses. There is presumably a version of the
Prom Week fiction which could explain away an "undo" option, but then
one would meet with the issue of inevitable victory seen above, but this
time with flavor text.

This is the challenge that games seeking to have rich AI and to task the
player with "what do I do now?" sorts of challenges. The in-game fiction
is usually something to the effect of "there are social beings in
this world and you can talk to them." If this is the case, then a
misstep is more than just a mis-aligned box: it is a slight, an offense,
a threat. It carries significant weight. One can "undo" in Sokoban
because there would never be a diegetic reason for the box to recall
what had happened to it (admittedly, some versions of Sokoban add
breakable tiles, which arguably _do_ "remember" actions, but even these
are themselves inanimate, and an "undo" to reverse their breaking is
small potatoes to the industrious warehouse worker). In Prom Week, and
this category of games in general, there is an automatic reaction on the
part of the player to apply meaning to the behavior of the game's
agents. There's a reason that flavor text is so important; yes, it helps
to surface the agents' reasoning, but it also _leans into_ what the
player is already thinking: "if I do something mean to this person, they
should react accordingly." Barks, voiceover lines, speech bubbles saying
"ouch!"—all of these serve to reinforce players' natural inclination to
ascribe thoughtfulness to agents that appear intelligent. There's no
dodging it. So, games with intricate systemic AI have a difficulty: how
do you make a puzzle that remembers when you misplace a piece?

---
layout: page
title: "clingo notes"
permalink: /clingo/
---

This is a collection of notes on the answer set programming system Clingo. Clingo is
notoriously... esoteric. These are the gotchas that I've noticed over my time learning
about the system.

The notes aren't organized right now; there aren't many of them. If I reach double
digits, I'll add section headings. Each hint includes a description of where/how I found
out about it.

---

### Use `-n $N` to provide up to `$N` solutions (`-n 0` to provide all of them)

Running `clingo SOMEFILE.lp -n 10` will try to find 10 solutions to the problem. If there
are fewer than 10, it will provide all of them.

Running `clingo SOMEFILE.lp -n 0` will provide every solution. Might take a while...

__Source:__ `clingo --help` under "Clasp.Solving Options:"
```
  --models,-n <n>         : Compute at most <n> models (0 for all)
```

### Use `--help=3` to see all of your options

If you run `clingo --help` expecting to find all of the options for the system, you'll
be sad. If you want to see _everything_, run `clingo --help=3` instead.

__Source:__ running `clingo --help`, in the "Basic Options" section:
```
  --help[=<n>],-h         : Print {1=basic|2=more|3=full} help and exit
```


### Use the flag `--outf=2` for JSON output

For machine-parseable output, add the flag `--outf=2`. This saves you the trouble of
having to parse the output yourself. Speaking from experience here.

- `--outf=0` is the default.

- `--outf=1` is "competition" (I don't know what that means)

- `--outf=2` is JSON output.

- `--out=3` is no output. Useful if you just want to see if the thing grounds/solves;
you'll still get error and info messages.

__Source:__ running `clingo --help=2` or `clingo --help=3`. Grep for "JSON" (all caps).

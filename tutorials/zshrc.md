---
layout: tutorial
title: My .zshrc, line-by-line
---

Here are the contents of my .zshrc:

```zsh
{% include zshrc %}
```

---

It's consistent across platforms, because I maintain a [repo of all of
my dotfiles][1] and then create a symlink to the repo directory, like
so:

```
    ln -s ~/path/to/dotfiles/.zsrhc ~/.zsrhc
```

What follows is a blow-by-blow explaining each line.

## Prezto

[Prezto][5] is a zsh framework that makes the zsh experience _vastly_
better. I highly recommend it, especially if you're not using zsh and
all of its wonderful features already.

```zsh
    if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
```

In bash and other shells, `"${VAR:-$OTHERVAR}"` expands to `$VAR`,
unless `$VAR` is unset or empty, in which case it expands to `$OTHERVAR`
(see [this explanation on parameter expansion][6]). Therefore,
`"${ZDOTDIR:-$HOME}"` is either one's `$ZDOTDIR` or one's `$HOME`
variable, which then gets a `/.zprezto/init.zsh` tacked on.

`-s`, (within the `[[ ]]`, which are the [extended format for
conditionals][2]), checks if the file exists _and_ if its contents are
non-zero in length. [Here is an exhaustive list of the various
conditionals and what they do][4].

All of this together makes for a conditional that checks if there exists
(in one's home or z dot directory) a non-empty file named
`.zprezto/init.zsh`.

```zsh
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
```

In this case, if that file does exist, we source it. In short, if this
script can find an appropriate `init.zsh` for the zprezto framework,
then it runs it. Simple as that.

```zsh
    autoload -Uz promptinit
    promptinit
    prompt minimal
```

These are lines for configuring Prezto's prompt. There are a bunch of
fancy prompts available, but I stick one of the simpler options so that
I can use this config file on my headless raspberry pi (which doesn't
have full unicode support).

## Miscellaneous Configurations

```zsh
    eval "$(fasd --init auto)"
```

[`fasd`][7] is an excellent augmentation of the vanilla `cd` command. It
sorts files/directories by "frecency" and affords quick access to the
files it predicts you'll need. This line initializes the utility.

```zsh
    export VISUAL=nvim
    export EDITOR="$VISUAL"
```

[These set my "default" editor to neovim.][8] ([Bonus explanation on the
difference between `$VISUAL` and `$EDITOR`][9])

## tmux

```zsh
[ -z $TMUX ] && { tmux attach || exec tmux new-session -s general && exit }
```

If `$TMUX` is set, then we're already somewhere in the tmuxverse and we
shouldn't create new sessions (nesting tmux sessions is rarely a good
ide). If `$TMUX` isn't set, this either attaches an existing, buried
session (`tmux attach`) or creates a new session named "general" (`exec
tmux new-session -s general`).

```zsh
tmux source ~/.tmux.conf
```

This sources my tmux config file.
<!-- TODO add the line-by-line for tmux -->


## Aliases

```zsh
    alias vim=nvim
```

This saves me the "trouble" of having to write `nvim` instead of `vim`.

<!--
```zsh
alias makepass='curl -X GET -G https://www.random.org/passwords/ 	-d "num=1" 	-d "len=24" 	-d "format=plain" 	-d "rnd=new" | pbcopy'
```
-->

```zsh
    alias makepass='curl -X GET -G https://www.random.org/passwords/ \
            -d "num=1" \
            -d "len=24" \
            -d "format=plain" 
            -d "rnd=new" | pbcopy'
```

Next, this chonker gets a random password from random.org and puts it into my
system clipboard. It's currently busted on Windows (where I use the
Windows Linux Subsystem), so I need to account for that at some
juncture.

```zsh
    alias polo=". polo"
```

A while back I wrote a pair of scripts, `marco`:

```zsh
    #!/bin/zsh

    val=$(pwd)
    base=$(dirname $(readlink "$(dirname ${(%):-%N})/marco"))
    echo "$val" > "$base/.polo_value"
```

and `polo`:

```zsh
    #!/bin/zsh

    base=$(dirname $(readlink "$(dirname ${(%):-%N})/marco"))
    file="$base/.polo_value"

    if [ -f $file ]; then
        cd $(cat $file)
    else
        echo "Nothing polo'ed!"
    fi
```

However, calling `cd` from within a script only changes the working
directory for the subshell running the script, so one needs to source
the script by calling with `source $SCRIPT` or simply `. $SCRIPT`. So, I
aliased `polo` to source the script, hence: `alias polo=". polo"`.

## Ruby Configurations

```zsh
    export PATH="/usr/local/opt/ruby/bin:$PATH"
```

This includes the [homebrew][10] install of ruby in my path _before_ the
OSX default ruby install, so that programs find it beforehand.

```zsh
    alias js="bundle exec jekyll server"
```

To test this website, I run the command `bundle exec jekyll server`
frequently. This alias just saves me the trouble.

## Miscellaneous

```zsh
export PATH="/usr/local/texlive/2020/bin/x86_64-darwin/:$PATH"
```

This lets texlive know about my installation. It occurs to me that this
is broken on windows. Ugh. That's one of the nice things about a page
like this: it lets me see when I've goofed something up. It's like
long-form rubber ducky debugging.

```zsh
    export DOTNET_CLI_TELEMETRY_OPTOUT=1
```

This particular nonsense opts me out dotnet data collection from the
time I faffed around with f# for 20 minutes. A relic, to be sure.

## Coda: How This Page Was Written

Initially, this page's markdown included the line:

```liquid-markdown
{% raw %}
{% include zshrc %}
{% endraw %}
```

Where `zshrc` was symbollically linked to my `_includes` directory:

```
ln -s ~/.config/dotfiles/.zshrc _includes/zshrc
```

Which let me access the contents of the file from anywhere in the
directory.

So far, so good. But there's a bit of difficulty: if I changed the
contents of `~/.config/dotfiles/.zshrc`, the site would automagically
change the contents of this page, and I'll end up with an outdated
line-by-line that I'd have to fix/validate myself.

So, I had 0 effort to make sure that the body of the .zshrc ended up
here in my directory, but I had to manually ensure that new content got
explained (since that was, after all, the point of the line-by-line). We
try to automate everything we plan on doing around these parts, so I
tried the following solution:

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

When this is called as

```
./_checklinebyline ~/.zshrc ./zshrc.md
```

Every non-empty, non-comment line in my .zshrc that isn't _somewhere_ in
this file is printed. It's not a perfect solution (currently, it
struggles with multi-line commands, which `read` treats as being one
long command with random tabs sprinkled throughout), but it works for
now. It feels good to automate, however imperfectly.

[1]: https://github.com/ethanrobison/dotfiles
[2]: https://stackoverflow.com/questions/13542832/difference-between-single-and-double-square-brackets-in-bash
[4]: http://zsh.sourceforge.net/Doc/Release/Conditional-Expressions.html
[5]: https://github.com/sorin-ionescu/prezto
[6]: https://wiki.bash-hackers.org/syntax/pe#use_a_default_value
[7]: https://github.com/clvv/fasd
[8]: https://unix.stackexchange.com/questions/73484/how-can-i-set-vi-as-my-default-editor-in-unix#73486
[9]: https://unix.stackexchange.com/questions/4859/visual-vs-editor-what-s-the-difference
[10]: https://brew.sh/

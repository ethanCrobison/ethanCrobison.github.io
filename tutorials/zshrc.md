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
    ln -s ~/.config/dotfiles/.zsrhc ~/.zsrhc
```


What follows is a blow-by-blow explaining each line.

## Prezto

[Prezto][5] is a zsh framework that makes the zsh experience _vastly_
better. I highly recommend it, especially if you're not using zsh and
all of its wonderful features already.

```zsh
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
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
    if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
```

In this case, if that file does exist, then we source it:

```zsh
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
```

So, if this script can find an appropriate `init.zsh` for the zprezto
framework, then it runs it. Simple as that.

## Miscellaneous Configurations

```zsh
eval "$(fasd --init auto)"
agentid=$(eval $(ssh-agent))

export VISUAL=nvim
export EDITOR="$VISUAL"

tmux source ~/.tmux.conf
```

## Aliases

An alias can be thought of, 9 times out of 10, as a string that gets
substituted for a another at the command line. Call `alias ls='ls -lh'`
and typing watch your file listings became more useful. (If ever you
need the original behavior, you can call it as `\ls`.)

Here are the aliases that I wrote myself (my environment includes many
other aliases, thanks to some prezto modules):

```zsh
alias vim=nvim
alias makepass='curl -X GET -G https://www.random.org/passwords/ \
	-d "num=1" \
	-d "len=24" \
	-d "format=plain" 
	-d "rnd=new" | pbcopy'
alias polo=". polo"
```

This saves me the trouble of having to write `nvim` instead
of `vim`:

```zsh
    alias vim=nvim
```

Next, this chonker gets a random password from random.org and puts it into my
system clipboard. It's currently busted on Windows (where I use the
Windows Linux Subsystem), so I need to account for that at some
juncture.

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


<br>


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
aliased `polo` to source the script:

```zsh
    alias polo=". polo"
```

I can call these two scripts from anywhere (saying `marco` instead of,
e.g., `~/.config/dotfiles/utils/marco`) by running:

```
    sudo ln -s ~/.config/dotfiles/utils/marco /u
```

## Ruby Configurations

```zsh
# Ruby stuff
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
alias js="bundle exec jekyll server" # start up jekyll more easily
```

## Miscellaneous

```zsh
export DOTNET_CLI_TELEMETRY_OPTOUT=1
```


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

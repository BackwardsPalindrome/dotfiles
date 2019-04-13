# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
	[ -s "$BASE16_SHELL/profile_helper.sh" ] && \
		eval "$("$BASE16_SHELL/profile_helper.sh")"

# Restart trackpad, sometimes it freezes after laptop wakes from sleep
alias restartTrack='sudo modprobe -r psmouse && sudo modprobe psmouse'

# shortcut to typing clear all the time
alias c='clear'

# make dir and cd into it in one command
function mkcd { mkdir "$1" && cd "$1"; }

# quickly get to hdd
alias hdd='cd /mnt/HDD/Documents/Programming'

# Common update commands
alias update='sudo apt update && sudo apt upgrade -y'

# Open files from terminal with default file
alias o='xdg-open 2>/dev/null'

# Shortcut for todolist
alias td='todolist'

# Git Aliases
alias gits='git status'
alias gitb='git branch'

# gridsome is too long a word for a command
alias gs='gridsome'

# common xclip shortcuts
alias iclip="xclip -i -sel clipboard"
alias oclip="xclip -o -sel clipboard"

# pipenv aliases
alias prp='pipenv run python'

# Change tlp battery modes
alias acpower='sudo tlp ac'
alias batpower='sudo tlp bat'

# Launch journal with templates
alias jrnlm='jrnl < /mnt/HDD/Documents/journal/daily_template.txt && jrnl -1 --edit'
alias jrnle='jrnl -on today --edit'
function exportJrnl { jrnl --export markdown | pandoc -s -o "$1"; }

# Function to create a new project directory with commands I always run
function mkpro {
	mkcd "$PWD/$1";
	git init;
	cp ~/.new_project_config/gitignore ./.gitignore;
	echo "# ${1//_/ }" > README.md;
	cat ~/.new_project_config/readme_template.md >> $PWD/README.md;
}

export PATH=$PATH:/home/max/.go/bin

export GOPATH=/home/max/go

export PATH=$PATH:/home/max/go/bin
# Dealing with python path and versions
export PATH="/home/max/.pyenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/max/.go/bin:/home/max/go/bin:/home/max/.go/bin:/home/max/go/bin:/home/max/.go/bin:/home/max/go/bin:/home/max/.go/bin:/home/max/go/bin:/home/max/.go/bin:/home/max/go/bin"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PATH="/home/max/.local/bin:$PATH"

# Add sml compiler to path
export PATH="/usr/bin/sml:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/max/google-cloud-sdk/path.bash.inc' ]; then . '/home/max/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/max/google-cloud-sdk/completion.bash.inc' ]; then . '/home/max/google-cloud-sdk/completion.bash.inc'; fi

# added by Anaconda3 2018.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$(CONDA_REPORT_ERRORS=false '/home/max/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     \eval "$__conda_setup"
# else
#     if [ -f "/home/max/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/max/anaconda3/etc/profile.d/conda.sh"
#         CONDA_CHANGEPS1=false conda activate base
#     else
#         \export PATH="/home/max/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda init <<<

# Simple add anaconda to path
export PATH="/home/max/anaconda3/bin:$PATH"
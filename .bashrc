# ~/.bashrc: executed by bash(1) for non-login shells
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples

# if not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# unalias everything
unalias -a

# don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# if set, the pattern "**" used in a pathname expansion context will match all files and zero or more directories and
# subdirectories.
shopt -s globstar

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

# uncomment for a colored prompt, if the terminal has the capability; turned off by default to not distract the user:
# the focus in a terminal window should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # we have color support; assume it's compliant with Ecma-48 (ISO/IEC-6429) (lack of such support is extremely
        # rare, and such a case would tend to support setf rather than setaf)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[01;33m\] @ \[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u @ \h:\w\$ '
fi
unset color_prompt force_color_prompt

# if this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    [ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    # change that ugly Windows directory color
    LS_COLORS="$LS_COLORS:ow=01;34"

    # add colors for C/C++ and Python files
    LS_COLORS="$LS_COLORS:*.c=01;31:*.cpp=01;31:*.h=01;32:*.hpp=01;32:*.py=00;36"

    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# add an "alert" alias for long running commands, use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable this, if it's already enabled in /etc/bash.bashrc
# and /etc/profile sources /etc/bash.bashrc)
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

######################################
# CUSTOM CONTENT GENERALLY STARTS HERE
######################################

# source script exporting terminal colors
[ -r ~/.bash_colors.sh ] && . ~/.bash_colors.sh

# general constants, functions and aliases

[ -r ~/.bash_constants.sh ] && . ~/.bash_constants.sh
[ -r ~/.bash_functions.sh ] && . ~/.bash_functions.sh
[ -r ~/.bash_aliases ] && . ~/.bash_aliases

# enable git prompt (https://github.com/magicmonty/bash-git-prompt.git)
if [ -r ~/.bash-git-prompt/gitprompt.sh ]; then
  # set config variables first
  GIT_PROMPT_ONLY_IN_REPO=1

  # GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status

  GIT_PROMPT_SHOW_UPSTREAM=1 # uncomment to show upstream tracking branch
  GIT_PROMPT_SHOW_UNTRACKED_FILES=all # can be no, normal or all; determines counting of untracked files

  # GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0 # uncomment to avoid printing the number of changed files

  # GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh # uncomment to support Git older than 1.7.10

  # GIT_PROMPT_START=...    # uncomment for custom prompt start sequence
  # GIT_PROMPT_END=...      # uncomment for custom prompt end sequence

  # as last entry source the gitprompt script
  # GIT_PROMPT_THEME=Custom # use custom theme specified in file GIT_PROMPT_THEME_FILE (default ~/.git-prompt-colors.sh)
  # GIT_PROMPT_THEME_FILE=~/.git-prompt-colors.sh
  GIT_PROMPT_THEME=Evermeet_Ubuntu

  . ~/.bash-git-prompt/gitprompt.sh
fi

if [ "$SHLVL" -eq 1 ]; then
    greet_user
    sync_to_repo
    echo_repo_status
else
    echo -e "Going deeper to level ${_YELLOW}${SHLVL}${_RESET_ALL}"
fi

# custom settings

export EDITOR=vim

# load local, workspace specific configuration
[ -r ~/.local_configuration.sh ] && . ~/.local_configuration.sh 

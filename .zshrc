#!/bin/zsh

# color variables
black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
reset=`tput sgr0`


# aliases
alias g=git
alias l="ls -G"
alias sz="source ~/.zshrc"
alias cdu="cd .."

# my functions
function subdo () {
  {
    for dir in ./*
    do
      (
        cd "$dir" &&
        echo "${blue}\n====================================================" &&
        echo "=================== $(pwd) ===================\n${reset}" &&
        eval "$*"
      )
    done
  } 2>&1
}

# Custom Functions

# subdo goes into each subdir and does the task you input
function subdoless {
  {
    for dir in ./*;
    do (
        echo "=================================================================================" &&
        cd "$dir" &&
        pwd &&
        eval "$*"
        );
    done
  } 2>&1 | less
}

alias scr='screen -r'
alias g=git
alias l='ls -G'
alias sz='source ~/.zshrc'
alias az='atom ~/.zshrc'
alias deleted='sudo /usr/sbin/lsof | grep deleted'
alias du='sudo du --human-readable'
alias vgcfg='vim ~/.gitconfig'
alias vzsh='vim ~/.zshrc && source ~/.zshrc'
# alias l='ls --almost-all --color=yes --classify --quoting-style=escape'


# enable VCSINFO
# https://wiki.gentoo.org/wiki/Zsh/HOWTO
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "%r/%S %b (%a) %m%u%c "
precmd() {
    vcs_info
}
# add to prompt
setopt prompt_subst
PROMPT='${vcs_info_msg_0_}%# '

#
# make zsh autocomplete nicer
# https://wiki.gentoo.org/wiki/Zsh/HOWTO
ulimit -c unlimited
# Completion
autoload -U compinit
compinit
# Correction
setopt correctall
# Prompt
autoload -U promptinit
promptinit


zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'


## history
setopt APPEND_HISTORY
## for sharing history between zsh processes
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

export PS1="[%D %*] %d %% "

echo "zshrc done"

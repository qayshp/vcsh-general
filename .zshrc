#!/bin/zsh

# Fixes for path on one machine

# Use JDK 7 instea of 8, with both installed.
# from http://www.jayway.com/2014/01/15/how-to-switch-jdk-version-on-mac-os-x-maverick/
function setjdk() {
  if [ $# -ne 0 ]; then
   removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
   if [ -n "${JAVA_HOME+x}" ]; then
    removeFromPath $JAVA_HOME
   fi
   export JAVA_HOME=`/usr/libexec/java_home -v $@`
   export PATH=$JAVA_HOME/bin:$PATH
  fi
 }
 function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
 }
setjdk 1.7

# add maven to path
export PATH=~/clis/apache-maven-3.3.1/bin:$PATH

# add vcsh to path
export PATH=~/clis/vcsh-master:$PATH

# add newer git and git scripts to path
export GIT_EXEC_PATH=~/Applications/SourceTree.app/Contents/Resources/git_local/libexec/git-core/
export PATH=~/Applications/Applications/SourceTree.app/Contents/Resources/git_local/bin:$PATH

# alias atom
alias atom="sh ~/Applications/Atom.app/Contents/Resources/app/atom.sh"

#############################
# master VCSH

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
alias cdu='cd ..'
alias scr='screen -r'
alias g='git'
alias grep='grep --color=auto'
alias less='less --raw-control-chars'
alias ls='ls -G'
alias l='ls'
alias sz='source ~/.zshrc'
alias az='atom ~/.zshrc'
alias deleted='/usr/sbin/lsof | grep deleted'
alias du='du --human-readable'
alias vg='vim ~/.gitconfig'
alias vz='vim ~/.zshrc && source ~/.zshrc'
alias a='atom'
alias v='vim'
# alias l='ls --almost-all --color=yes --classify --quoting-style=escape'

# my functions
# subdo goes into each subdir and does the task you input, this one in color!
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
  } 2>&1 | less
}

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

# autoload -U colors
# colors

# get online help
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help


zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'


## history
setopt APPEND_HISTORY
## for sharing history between zsh processes
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

## keep background processes at full speed
setopt NOBGNICE
## restart running processes on exit
setopt HUP

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

export PS1="[%D %*] %~ %% "

echo ".zshrc applied"

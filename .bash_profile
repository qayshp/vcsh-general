alias g="git"
alias abrc="atom ~/.bashrc"
alias sbrc="source ~/.bashrc"
alias agit="atom ~/.gitconfig"
alias lbrc="less ~/.bashrc"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias ls='ls -GFh'

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

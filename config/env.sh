#!/bin/zsh

export EDITOR='nvim'

# PATH
export BREW="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export SYSTEM="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
export X11="/usr/X11/bin"
export RUBY="~/.rvm/bin"
export MAMP="/Applications/MAMP/bin/php/php5.6.2/bin/php"

export PATH="$BREW:$SYSTEM:$X11:$RUBY"

# Owner
export USER_NAME="dev"

# FileSearch
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

#mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }

# Aliases
alias l='l -lahL'
alias gs='git status'
alias gc='git commit'
alias gd='git diff'

# PHP Ctag helper
alias phpctags='ctags -R --fields=+aimS --languages=php'

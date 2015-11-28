#!/bin/zsh

export EDITOR='vim'

# PATH
export BREW="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export SYSTEM="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
export X11="/usr/X11/bin"
export RUBY="~/.rvm/bin"

export PATH="$BREW:$SYSTEM:$X11:$RUBY"

# Owner
export USER_NAME="dev"

# FileSearch
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

#mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }

# Aliases
alias cppcompile='c++ -std=c++11 -stdlib=libc++'
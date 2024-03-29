#!/bin/zsh

export EDITOR='nvim'
export PHP_VERSION='php7.0.0'

# PATH
export BREW="/usr/local/bin:/usr/local/sbin"
export SYSTEM="/usr/bin:/bin:/usr/sbin:/sbin"
export X11="/usr/X11/bin"
export RUBY="~/.rvm/bin:~/.rvm/gems"
# export COMPOSER="~/.composer/vendor/bin"
# export MAMP="/Applications/MAMP/bin/php/${PHP_VERSION}/bin"
export PHP="/usr/local/Cellar/php@7.1/7.1.21/bin"
export QT="/usr/local/opt/qt@5/bin"
export PATH="$PHP:$QT:$BREW:$SYSTEM:$X11"

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

if [[ $hostname == cambook* ]]; then
    alias wp="$MAMP/wp-cli.phar"
fi

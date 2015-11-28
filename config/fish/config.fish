set fish_path $HOME/.oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

Plugin "z"
Plugin "tmux"
Plugin "osx"

alias c='clear'

# Open in Finder
alias f='open -a Finder ./'

# Reassign our old pal, the clear-console shortcut.
bind \cq clear; commandline -f repaint

# Git
alias gs='git status'
alias gd='git diff'
alias ga='git add .'
alias gc='git commit -m' # requires you to type a commit message

alias  composer='php /usr/local/bin/composer/composer.phar'
alias mcomposer='/Applications/MAMP/bin/php/php5.6.2/bin/php /usr/local/bin/composer/composer.phar'
alias    phpcsf='~/.composer/vendor/fabpot/php-cs-fixer/php-cs-fixer'
alias       pac='php app/console'
alias      mphp='/Applications/MAMP/bin/php/php5.6.2/bin/php'
alias        wp='/Applications/MAMP/bin/php/php5.6.2/bin/php /usr/local/bin/wp'
alias       vim='/usr/local/Cellar/macvim/7.4-77/MacVim.app/Contents/MacOS/Vim'

# Networking
alias myip='curl ipinfo.io'                         # myip:         Public facing IP Address
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache

# Web Dev
alias eh='sudo vim /etc/hosts'
alias evh='sudo vim /Applications/MAMP/conf/apache/extra/httpd-vhosts.conf'

# Tmux
alias tl='tmux list-sessions'
alias tma='tmux attach -t'
alias tmn='tmux new-session -s'

# 🐘  Mamp's binaries are better. Setting them ahead of system PHP
# allows for wp-cli to leverage the mysqldump command
set PATH /Applications/MAMP/bin/php/php5.6.2/bin $PATH

# Homebrew in the PATH 🍺  (brew doctor reccommends this before anything else)
set -l brew_paths /usr/local/bin /usr/local/sbin
set PATH $brew_paths $PATH

# Powerline
function fish_prompt
  ~/.powerline-shell/powerline-shell.py $status --shell bare ^/dev/null
  echo -e \r\n(set_color -o cyan)'☞  '
end

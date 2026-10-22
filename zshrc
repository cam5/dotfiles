export NVM_DIR="$HOME/.nvm"
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
  \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
elif [ -s "$NVM_DIR/nvm.sh" ]; then
  \. "$NVM_DIR/nvm.sh"  # nvm's own installer (Linux)
fi
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

GPG_TTY=$(tty)
export GPG_TTY

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Shopify Hydrogen alias to local projects
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'

# git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gl="git log --graph --pretty=format:'%C(yellow)%h%Creset -%C(auto)%d%Creset %s %C(green)(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Open every changed/staged/untracked file in nvim buffers.
# Function, not an alias, so it works from any subdirectory of the repo.
gv() {
  local root
  root=$(git rev-parse --show-toplevel) || return 1
  local -a files
  files=(${(u)${(f)"$(
    git -C $root diff --name-only --diff-filter=d
    git -C $root diff --name-only --diff-filter=d --cached
    git -C $root ls-files --others --exclude-standard
  )"}})
  (( $#files )) || { print -u2 "gv: no changed files"; return 1 }
  nvim -- ${files/#/$root/}
}

# Open the pull request for the current branch in the default browser.
# Falls back to GitHub's "create PR" page when the branch has no PR yet.
ghp() {
  local url
  url=$(gh pr view --json url --jq .url 2>/dev/null)
  if [[ -n $url ]]; then
    open "$url"
  else
    print -u2 "ghp: no PR for this branch yet - opening the create page"
    gh pr create --web
  fi
}

alias claudee='claude --dangerously-skip-permissions'

export PATH="$HOME/.local/bin:$PATH"
# Initialise the completion system (compdef, _tmux, brew completions, ...).
autoload -Uz compinit
compinit

# >>> railway initialize >>>
[[ -f "$HOME/.railway/env" ]] && source "$HOME/.railway/env"
# <<< railway initialize <<<

# direnv
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"

# starship prompt
(( $+commands[starship] )) && eval "$(starship init zsh)"

# tmux: `ta <Tab>` completes live session names (via zsh's _tmux completion).
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tl='tmux list-sessions'

# md2rtf <file.md>: puts the file's rendered markdown on the clipboard as
# real rich text (bold/headings/lists/links), for pasting into a WYSIWYG
# editor (Mail, Fastmail's compose box, Google Docs, etc). Piping straight
# to pbcopy doesn't work here -- pbcopy's RTF auto-detection writes the
# legacy Carbon RTF pasteboard type, which failed round-tripping through
# AppleScript's own `as «class RTF »` coercion (error -1700) when tested; the
# `read ... as «class HTML»` form below registers the modern type that
# browser-based editors actually read on paste.
md2rtf() {
    if [ -z "$1" ]; then
        echo "usage: md2rtf <file.md>" >&2
        return 1
    fi
    local html_file
    html_file="$(mktemp -t md2rtf).html"
    pandoc -f gfm -t html "$1" -o "$html_file" || return 1
    osascript -e "set the clipboard to (read (POSIX file \"$html_file\") as «class HTML»)"
    rm -f "$html_file"
    echo "Copied $1 to the clipboard as rich text." >&2
}

# Machine-local config (tool completions, local-path aliases); not tracked.
[[ -f ~/.zshrc.extra ]] && source ~/.zshrc.extra

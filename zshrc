export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
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

#compdef nightshift
compdef _nightshift nightshift

# zsh completion for nightshift                           -*- shell-script -*-

__nightshift_debug()
{
    local file="$BASH_COMP_DEBUG_FILE"
    if [[ -n ${file} ]]; then
        echo "$*" >> "${file}"
    fi
}

_nightshift()
{
    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16
    local shellCompDirectiveKeepOrder=32

    local lastParam lastChar flagPrefix requestComp out directive comp lastComp noSpace keepOrder
    local -a completions

    __nightshift_debug "\n========= starting completion logic =========="
    __nightshift_debug "CURRENT: ${CURRENT}, words[*]: ${words[*]}"

    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $CURRENT location, so we need
    # to truncate the command-line ($words) up to the $CURRENT location.
    # (We cannot use $CURSOR as its value does not work when a command is an alias.)
    words=("${=words[1,CURRENT]}")
    __nightshift_debug "Truncated words[*]: ${words[*]},"

    lastParam=${words[-1]}
    lastChar=${lastParam[-1]}
    __nightshift_debug "lastParam: ${lastParam}, lastChar: ${lastChar}"

    # For zsh, when completing a flag with an = (e.g., nightshift -n=<TAB>)
    # completions must be prefixed with the flag
    setopt local_options BASH_REMATCH
    if [[ "${lastParam}" =~ '-.*=' ]]; then
        # We are dealing with a flag with an =
        flagPrefix="-P ${BASH_REMATCH}"
    fi

    # Prepare the command to obtain completions
    requestComp="${words[1]} __complete ${words[2,-1]}"
    if [ "${lastChar}" = "" ]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go completion code.
        __nightshift_debug "Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi

    __nightshift_debug "About to call: eval ${requestComp}"

    # Use eval to handle any environment variables and such
    out=$(eval ${requestComp} 2>/dev/null)
    __nightshift_debug "completion output: ${out}"

    # Extract the directive integer following a : from the last line
    local lastLine
    while IFS='\n' read -r line; do
        lastLine=${line}
    done < <(printf "%s\n" "${out[@]}")
    __nightshift_debug "last line: ${lastLine}"

    if [ "${lastLine[1]}" = : ]; then
        directive=${lastLine[2,-1]}
        # Remove the directive including the : and the newline
        local suffix
        (( suffix=${#lastLine}+2))
        out=${out[1,-$suffix]}
    else
        # There is no directive specified.  Leave $out as is.
        __nightshift_debug "No directive found.  Setting do default"
        directive=0
    fi

    __nightshift_debug "directive: ${directive}"
    __nightshift_debug "completions: ${out}"
    __nightshift_debug "flagPrefix: ${flagPrefix}"

    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        __nightshift_debug "Completion received error. Ignoring completions."
        return
    fi

    local activeHelpMarker="_activeHelp_ "
    local endIndex=${#activeHelpMarker}
    local startIndex=$((${#activeHelpMarker}+1))
    local hasActiveHelp=0
    while IFS='\n' read -r comp; do
        # Check if this is an activeHelp statement (i.e., prefixed with $activeHelpMarker)
        if [ "${comp[1,$endIndex]}" = "$activeHelpMarker" ];then
            __nightshift_debug "ActiveHelp found: $comp"
            comp="${comp[$startIndex,-1]}"
            if [ -n "$comp" ]; then
                compadd -x "${comp}"
                __nightshift_debug "ActiveHelp will need delimiter"
                hasActiveHelp=1
            fi

            continue
        fi

        if [ -n "$comp" ]; then
            # If requested, completions are returned with a description.
            # The description is preceded by a TAB character.
            # For zsh's _describe, we need to use a : instead of a TAB.
            # We first need to escape any : as part of the completion itself.
            comp=${comp//:/\\:}

            local tab="$(printf '\t')"
            comp=${comp//$tab/:}

            __nightshift_debug "Adding completion: ${comp}"
            completions+=${comp}
            lastComp=$comp
        fi
    done < <(printf "%s\n" "${out[@]}")

    # Add a delimiter after the activeHelp statements, but only if:
    # - there are completions following the activeHelp statements, or
    # - file completion will be performed (so there will be choices after the activeHelp)
    if [ $hasActiveHelp -eq 1 ]; then
        if [ ${#completions} -ne 0 ] || [ $((directive & shellCompDirectiveNoFileComp)) -eq 0 ]; then
            __nightshift_debug "Adding activeHelp delimiter"
            compadd -x "--"
            hasActiveHelp=0
        fi
    fi

    if [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]; then
        __nightshift_debug "Activating nospace."
        noSpace="-S ''"
    fi

    if [ $((directive & shellCompDirectiveKeepOrder)) -ne 0 ]; then
        __nightshift_debug "Activating keep order."
        keepOrder="-V"
    fi

    if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
        # File extension filtering
        local filteringCmd
        filteringCmd='_files'
        for filter in ${completions[@]}; do
            if [ ${filter[1]} != '*' ]; then
                # zsh requires a glob pattern to do file filtering
                filter="\*.$filter"
            fi
            filteringCmd+=" -g $filter"
        done
        filteringCmd+=" ${flagPrefix}"

        __nightshift_debug "File filtering command: $filteringCmd"
        _arguments '*:filename:'"$filteringCmd"
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only
        local subdir
        subdir="${completions[1]}"
        if [ -n "$subdir" ]; then
            __nightshift_debug "Listing directories in $subdir"
            pushd "${subdir}" >/dev/null 2>&1
        else
            __nightshift_debug "Listing directories in ."
        fi

        local result
        _arguments '*:dirname:_files -/'" ${flagPrefix}"
        result=$?
        if [ -n "$subdir" ]; then
            popd >/dev/null 2>&1
        fi
        return $result
    else
        __nightshift_debug "Calling _describe"
        if eval _describe $keepOrder "completions" completions $flagPrefix $noSpace; then
            __nightshift_debug "_describe found some completions"

            # Return the success of having called _describe
            return 0
        else
            __nightshift_debug "_describe did not find completions."
            __nightshift_debug "Checking if we should do file completion."
            if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
                __nightshift_debug "deactivating file completion"

                # We must return an error code here to let zsh know that there were no
                # completions found by _describe; this is what will trigger other
                # matching algorithms to attempt to find completions.
                # For example zsh can match letters in the middle of words.
                return 1
            else
                # Perform file completion
                __nightshift_debug "Activating file completion"

                # We must return the result of this command, so it must be the
                # last command, or else we must store its result to return it.
                _arguments '*:filename:_files'" ${flagPrefix}"
            fi
        fi
    fi
}

# don't run the completion function when being source-ed or eval-ed
if [ "$funcstack[1]" = "_nightshift" ]; then
    _nightshift
fi

# >>> railway initialize >>>
source "$HOME/.railway/env"
# <<< railway initialize <<<

# direnv
eval "$(direnv hook zsh)"

# starship prompt
eval "$(starship init zsh)"

# tmux: `ta <Tab>` completes live session names (via zsh's _tmux completion).
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tl='tmux list-sessions'

# semble CLI (goals over the semble-data vault)
alias semble='/Users/cameron/projects/semble/bin/semble'

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

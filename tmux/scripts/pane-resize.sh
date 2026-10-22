#!/bin/sh
# Grow or shrink a tmux pane from a chosen side.
#
# tmux's resize-pane -L/-R/-U/-D move a *border* in an absolute direction,
# picking whichever of the pane's two borders happens to be movable. The
# upshot is that the same keystroke grows the pane in one position and
# shrinks it in another: for a left-hand pane `-R` widens, but for a
# right-hand pane `-R` narrows. That makes "shift means shrink" impossible
# to express with the bare commands.
#
# This wrapper takes the side to act on plus the intent (grow/shrink) and
# picks the command that actually realises that intent:
#
#   - Acting on the far side (the one with a neighbour) resizes this pane.
#   - Acting on the near side moves the *shared border with the neighbour*,
#     which means resizing the neighbour in the opposite direction.
#   - When the requested side is the window edge there is no border to move,
#     so fall back to the opposite border. That still honours the intent
#     (the pane does grow, or shrink), it just comes off the other side --
#     which keeps every key useful instead of dead in edge panes.
#
# Neighbour targets ({left-of} etc.) resolve against the window's active
# pane, which is always the pane a key binding fires from.
#
# Usage: pane-resize.sh <pane_id> <left|right|up|down> <grow|shrink> [amount]

pane="$1"
side="$2"
mode="$3"
amount="${4:-5}"

[ -n "$pane" ] && [ -n "$side" ] && [ -n "$mode" ] || exit 0

# Where does this pane sit relative to the window edges?
flags=$(tmux display-message -p -t "$pane" \
  '#{pane_at_left} #{pane_at_right} #{pane_at_top} #{pane_at_bottom}' 2>/dev/null)
# shellcheck disable=SC2086
set -- $flags
atl="$1" atr="$2" att="$3" atb="$4"

# An unresolvable pane still yields a blank-but-nonempty line from
# display-message, so verify we got real flags rather than empty fields.
case "$atl$atr$att$atb" in
  ????) ;;
  *) exit 0 ;;
esac

# resize_self <flag_for_grow> <flag_for_shrink>
resize_self() {
  if [ "$mode" = grow ]; then flag="$1"; else flag="$2"; fi
  tmux resize-pane -t "$pane" "$flag" "$amount"
}

# resize_neighbour <target> <flag_for_grow> <flag_for_shrink>
# Growing this pane means shrinking the neighbour, so the flags are the
# ones that move their shared border away from us.
resize_neighbour() {
  target="$1"
  if [ "$mode" = grow ]; then flag="$2"; else flag="$3"; fi
  tmux resize-pane -t "$target" "$flag" "$amount" 2>/dev/null
}

case "$side" in
  right)
    if [ "$atr" = 0 ]; then resize_self -R -L
    elif [ "$atl" = 0 ]; then resize_self -L -R
    fi
    ;;
  left)
    if [ "$atl" = 0 ]; then resize_neighbour '{left-of}' -L -R
    elif [ "$atr" = 0 ]; then resize_self -R -L
    fi
    ;;
  down)
    if [ "$atb" = 0 ]; then resize_self -D -U
    elif [ "$att" = 0 ]; then resize_self -U -D
    fi
    ;;
  up)
    if [ "$att" = 0 ]; then resize_neighbour '{up-of}' -U -D
    elif [ "$atb" = 0 ]; then resize_self -D -U
    fi
    ;;
esac

exit 0

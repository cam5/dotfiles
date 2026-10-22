#!/bin/sh
# Friendly display name for a tmux pane's foreground process.
#
# tmux's pane_current_command reflects the OS-reported process name of the
# pane's foreground job, which Claude Code sets to its own version string
# (e.g. "2.1.251") rather than "claude". Rather than pattern-matching that
# version-shaped string (fragile: any unrelated process named "x.y.z" would
# also match), walk from the pane's shell pid to its actual foreground
# child and check the real binary path.
#
# Usage: pane-command.sh <shell_pid> <fallback_name>

shell_pid="$1"
fallback="$2"

child_pid=$(ps -eo pid,ppid= | awk -v p="$shell_pid" '$2==p{print $1; exit}')

if [ -n "$child_pid" ]; then
  cmd=$(ps -o command= -p "$child_pid" 2>/dev/null)
  case "$cmd" in
    */claude\ *|*/claude)
      echo "claude"
      exit 0
      ;;
  esac
fi

echo "$fallback"

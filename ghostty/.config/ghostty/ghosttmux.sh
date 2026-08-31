#!/bin/sh
# Launched by ghostty's `initial-command`. Attaches to the workspace session,
# creating it first if it does not exist.
#
# NOTE: ghostty spawns this with a minimal environment, so /opt/homebrew/bin is
# NOT on PATH. Every tmux call must go through $TMUX_BIN -- a bare `tmux` here
# fails silently.

TMUX_BIN="/opt/homebrew/bin/tmux"
SESSION_NAME="workspace"

# "=name" is tmux's exact-match target syntax, so this cannot latch onto some
# other session that merely starts with the same prefix.
if "$TMUX_BIN" has-session -t "=$SESSION_NAME" 2>/dev/null; then
  exec "$TMUX_BIN" attach-session -t "=$SESSION_NAME"
else
  "$TMUX_BIN" -u new-session -d -s "$SESSION_NAME" -n "home"
  "$TMUX_BIN" select-window -t "$SESSION_NAME:home"
  exec "$TMUX_BIN" attach-session -t "=$SESSION_NAME"
fi

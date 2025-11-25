#!/bin/bash

AEROSPACE_BIN="/opt/homebrew/bin/aerospace"
if [ ! -x "$AEROSPACE_BIN" ]; then
  AEROSPACE_BIN="$(command -v aerospace 2>/dev/null)"
fi

[ -z "$AEROSPACE_BIN" ] && exit 0

workspace=$("$AEROSPACE_BIN" list-workspaces --focused 2>/dev/null | awk 'NF {print $1; exit}')
[ -z "$workspace" ] && exit 0

"$AEROSPACE_BIN" list-windows --workspace "$workspace" --format '%{window-id}' 2>/dev/null | while read -r win_id; do
  [ -z "$win_id" ] && continue
  "$AEROSPACE_BIN" fullscreen on --window-id "$win_id" --no-outer-gaps >/dev/null 2>&1
  "$AEROSPACE_BIN" fullscreen off --window-id "$win_id" >/dev/null 2>&1
  "$AEROSPACE_BIN" fullscreen on --window-id "$win_id" --no-outer-gaps >/dev/null 2>&1
  "$AEROSPACE_BIN" fullscreen off --window-id "$win_id" >/dev/null 2>&1
  break
 done

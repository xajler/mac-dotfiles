#!/bin/bash

TARGETS=(2 5 9)

AEROSPACE_BIN="/opt/homebrew/bin/aerospace"
if [ ! -x "$AEROSPACE_BIN" ]; then
  AEROSPACE_BIN="$(command -v aerospace 2>/dev/null)"
fi

[ -z "$AEROSPACE_BIN" ] && exit 0

focus_ws=$("$AEROSPACE_BIN" list-workspaces --focused 2>/dev/null | awk 'NF {print $1; exit}')
[ -z "$focus_ws" ] && focus_ws="${AEROSPACE_FOCUSED_WORKSPACE:-}"

for ws in "${TARGETS[@]}"; do
  "$AEROSPACE_BIN" list-windows --workspace "$ws" --format '%{window-id}' 2>/dev/null | while read -r win_id; do
    [ -z "$win_id" ] && continue
    "$AEROSPACE_BIN" fullscreen off --window-id "$win_id" >/dev/null 2>&1
  done
done

for ws in "${TARGETS[@]}"; do
  if [ "$ws" = "$focus_ws" ]; then
    "$AEROSPACE_BIN" list-windows --workspace "$ws" --format '%{window-id}' 2>/dev/null | while read -r win_id; do
      [ -z "$win_id" ] && continue
      "$AEROSPACE_BIN" fullscreen on --window-id "$win_id" --no-outer-gaps >/dev/null 2>&1
    done
    break
  fi
done

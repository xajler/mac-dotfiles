#!/bin/bash

TARGETS=(2 5 9)
STATE_FILE="$HOME/.config/aerospace/.stay_prev"
LOGFILE="$HOME/.config/aerospace/workspace_stay.log"

CANDIDATES=(
  "/opt/homebrew/bin/aerospace"
  "/usr/local/bin/aerospace"
  "/Applications/AeroSpace.app/Contents/MacOS/aerospace"
  "/Applications/AeroSpace.app/Contents/MacOS/AeroSpace"
)

AEROSPACE_BIN=""
for bin in "${CANDIDATES[@]}"; do
  if [ -x "$bin" ]; then
    AEROSPACE_BIN="$bin"
    break
  fi
 done

if [ -z "$AEROSPACE_BIN" ]; then
  AEROSPACE_BIN="$(command -v aerospace 2>/dev/null)"
fi

echo "[$(date '+%F %T')] bin=$AEROSPACE_BIN" >>"$LOGFILE"

[ -z "$AEROSPACE_BIN" ] && exit 0

current_ws=$("$AEROSPACE_BIN" list-workspaces --focused --json 2>/dev/null | jq -r '.[0].workspace' 2>/dev/null)
if [ -z "$current_ws" ]; then
  current_ws=$("$AEROSPACE_BIN" list-workspaces --focused 2>/dev/null | awk 'NF {print $1; exit}')
fi
prev_ws=""
[ -f "$STATE_FILE" ] && prev_ws=$(cat "$STATE_FILE")

echo "[$(date '+%F %T')] current=$current_ws prev=$prev_ws" >>"$LOGFILE"

[ -z "$current_ws" ] && exit 0

echo "$current_ws" >"$STATE_FILE"

for target in "${TARGETS[@]}"; do
  if [ "$target" = "$prev_ws" ] && [ "$prev_ws" != "$current_ws" ]; then
    count=$("$AEROSPACE_BIN" list-windows --workspace "$prev_ws" --count 2>/dev/null | tr -d '[:space:]')
    [ -z "$count" ] && count=0
    echo "[$(date '+%F %T')] target=$prev_ws count=$count" >>"$LOGFILE"
    if [ "$count" -eq 0 ]; then
      echo "[$(date '+%F %T')] switching_to=$prev_ws" >>"$LOGFILE"
      "$AEROSPACE_BIN" workspace "$prev_ws" >/dev/null 2>&1
    fi
    break
  fi
done

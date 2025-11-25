#!/bin/bash

TARGET_WORKSPACE="5"
APPS=("Zen" "Zen Browser" "ZenBrowser")

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

[ -z "$AEROSPACE_BIN" ] && exit 0

if ! command -v jq >/dev/null 2>&1; then
  exit 0
fi

windows_json="$($AEROSPACE_BIN list-windows --all --json 2>/dev/null)"
[ -z "$windows_json" ] && exit 0

echo "$windows_json" | jq -r '.[] | [."window-id", .workspace, ."app-name"] | @tsv' | while IFS=$'\t' read -r win_id workspace app_name; do
  [ -z "$win_id" ] && continue
  if [ "$workspace" = "$TARGET_WORKSPACE" ]; then
    continue
  fi
  for target_app in "${APPS[@]}"; do
    if [ "$app_name" = "$target_app" ]; then
      "$AEROSPACE_BIN" move-node-to-workspace "$TARGET_WORKSPACE" --window-id "$win_id" >/dev/null 2>&1
      break
    fi
  done
 done

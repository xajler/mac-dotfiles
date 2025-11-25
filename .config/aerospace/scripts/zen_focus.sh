#!/bin/bash

APP_NAME="${AEROSPACE_FOCUSED_APP_NAME:-}"
PREV_APP="${AEROSPACE_PREVIOUS_APP_NAME:-}"
FOCUSED_WIN="${AEROSPACE_FOCUSED_WINDOW_ID:-}"
PREV_WIN="${AEROSPACE_PREVIOUS_WINDOW_ID:-}"

LOG_FILE="$HOME/.config/aerospace/zen_focus.log"

timestamp() {
  date '+%Y-%m-%d %H:%M:%S'
}

log() {
  printf '[%s] %s\n' "$(timestamp)" "$1" >>"$LOG_FILE"
}

AEROSPACE_BIN="/opt/homebrew/bin/aerospace"
if [ ! -x "$AEROSPACE_BIN" ]; then
  AEROSPACE_BIN="$(command -v aerospace 2>/dev/null)"
fi

run_aerospace() {
  if [ -n "$AEROSPACE_BIN" ]; then
    "$AEROSPACE_BIN" "$@" >/dev/null 2>&1
  else
    log "ERROR: aerospace binary not found"
  fi
}

log "focus=$APP_NAME($FOCUSED_WIN) prev=$PREV_APP($PREV_WIN)"

is_zen() {
  case "$1" in
    "Zen"|"Zen Browser"|"ZenBrowser")
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

if is_zen "$APP_NAME"; then
  log "Applying fullscreen on for Zen"
  if [ -n "$FOCUSED_WIN" ]; then
    run_aerospace fullscreen on --window-id "$FOCUSED_WIN" --no-outer-gaps
  else
    run_aerospace fullscreen on --no-outer-gaps
  fi
fi

if is_zen "$PREV_APP"; then
  log "Releasing fullscreen for previous Zen"
  if [ -n "$PREV_WIN" ]; then
    run_aerospace fullscreen off --window-id "$PREV_WIN"
  else
    run_aerospace fullscreen off
  fi
fi

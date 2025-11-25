#!/bin/zsh

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Get outdated count directly (no brew update - faster and less prone to failure)
formulae=$(brew outdated --quiet 2>/dev/null | grep -c '^' || echo 0)
casks=$(brew outdated --cask --greedy --quiet 2>/dev/null | grep -c '^' || echo 0)

# Calculate total
total=$((formulae + casks))

# Always restore icon and update label (in case it was showing loading)
sketchybar --set widgets.brew \
  icon.string="􁕜" \
  icon.color=0x99e2e2e3 \
  label.string="$total" \
  label.color=0xff7f8490

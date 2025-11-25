#!/bin/zsh

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Get outdated packages
formulae=$(brew outdated --quiet 2>/dev/null || true)
casks=$(brew outdated --cask --greedy --quiet 2>/dev/null || true)

# Combine and format
output=""

if [[ -n "$formulae" ]]; then
  while IFS= read -r line; do
    [[ -n "$line" ]] && output+="📦 $line\n"
  done <<< "$formulae"
fi

if [[ -n "$casks" ]]; then
  while IFS= read -r line; do
    [[ -n "$line" ]] && output+="🍺 $line\n"
  done <<< "$casks"
fi

if [[ -z "$output" ]]; then
  echo "✓ All up to date"
else
  echo -n "$output" | sed 's/\\n$//'
fi

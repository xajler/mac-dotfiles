#!/bin/bash
LOGFILE="$HOME/.config/aerospace/env_debug.log"
{
  echo "---- $(date) ----"
  env | sort
} >> "$LOGFILE"

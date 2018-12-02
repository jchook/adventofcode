#!/usr/bin/env bash
DIR=$(pwd)
DIVIDER="
--------------------------------------------------
"
"$@"
echo "$DIVIDER"

inotifywait -q -e CLOSE_WRITE -r -m "$DIR" |
while read -r directory events filename; do
  if grep -q -E '\.hs$' <<< "$filename"; then
    "$@"
    echo "$DIVIDER"
  fi
done


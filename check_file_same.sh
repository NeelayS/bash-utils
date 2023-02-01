#!/bin/bash

# cmp --silent $1 $2 && echo '### SUCCESS: Files Are Identical! ###' || echo '### WARNING: Files Are Different! ###'

if cmp --silent -- $1 $2; then
  echo "files contents are identical"
else
  echo "files differ"
fi

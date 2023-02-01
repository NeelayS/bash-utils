#!/bin/bash

# cmp --silent $1 $2 && echo 'Files are identical!' || echo 'Files are different!'

if cmp --silent -- $1 $2; then
  echo "Files are identical!"
else
  echo "Files are different!"
fi

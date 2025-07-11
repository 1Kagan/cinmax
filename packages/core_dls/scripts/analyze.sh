#!/bin/bash
set -e

cd ..

if flutter analyze 2>&1 | grep -q -E 'error|warning|info'; then 
  echo "Correct lint issues"
  exit 1
else 
  echo "No Errors and Warnings"
  exit 0
fi

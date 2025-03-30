#!/bin/bash

set -e

# Check if sops is installed
if ! command -v sops &>/dev/null; then
  echo "Error: sops is not installed. Please install it first." >&2
  exit 1
fi

staged_files=$(git diff --cached --name-only "*.sops.yaml")

if [ -z "$staged_files" ]; then
  echo "No sops files staged for commit" >&2
  exit 0
fi

while IFS= read -r file; do
  if [[ -f "$file" ]]; then
    if ! sops -i -e "$file" &>/dev/null; then
      echo "File $file is already encrypted, skipping..." >&2
    else
      echo "Encrypted $file"
      if ! git add "$file"; then
        echo "Failed to add $file after encryption" >&2
      fi
    fi
  fi
done <<<"$staged_files"

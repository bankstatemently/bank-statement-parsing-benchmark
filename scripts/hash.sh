#!/usr/bin/env bash
#
# Compute the SHA-256 content hash of a benchmark statement PDF.
# This is the value you pass as "contentHash" to the evaluation API.
#
# Usage:
#   ./scripts/hash.sh datasets/basic/bsb-001/bsb-001-statement.pdf
#   ./scripts/hash.sh path/to/any-statement.pdf

set -euo pipefail

if [ $# -eq 0 ]; then
  echo "Usage: $0 <pdf-file>" >&2
  exit 1
fi

FILE="$1"

if [ ! -f "$FILE" ]; then
  echo "Error: file not found: $FILE" >&2
  exit 1
fi

shasum -a 256 "$FILE" | cut -d' ' -f1

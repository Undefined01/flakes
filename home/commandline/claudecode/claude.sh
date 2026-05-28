#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CC_APIKEY_SH="${CC_APIKEY_SH:-$SCRIPT_DIR/api_keys}"

if [[ -n "${ANTHROPIC_AUTH_TOKEN:-}" && -n "${CC_PROFILE:-}" ]]; then
    echo "Cannot specify both ANTHROPIC_AUTH_TOKEN and CC_PROFILE"
    exit 1
fi

if [[ -f "$CC_APIKEY_SH" ]]; then
    source "$CC_APIKEY_SH"
fi

${CLAUDE_CODE:-claude} "$@"


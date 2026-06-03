#!/usr/bin/env bash

set -euo pipefail

export TAVILY_API_KEY=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
export GROK_API_URL=https://octopus.lihan.fun/v1
export GROK_API_KEY=sk-octopus-L6YPPcSKlhDFlbp8TEr7T4Zjpfo0bC9zZS1a2CZuYjdTgdLu

export EXA_API_URL=https://exa.chengtx.vip
export EXA_API_KEY=exf_iZ2Iz9gBjMxJPw5oOEeRrbcG3Co3rI1fH421mDTxKBpWY6lu

export GROK_MODEL="grok-4.1"

export INFINITE_API_KEY=sk-4pq1rUFCZLMCd3FXv8fCN4E0zHBRecDt
export OCTOPUS_API_KEY=sk-octopus-L6YPPcSKlhDFlbp8TEr7T4Zjpfo0bC9zZS1a2CZuYjdTgdLu

# If no arguments provided, default to `--profile gpt52 resume`.
if [ "$#" -eq 0 ]; then
	set -- resume
fi

# If OPENAI_API_KEY is set, set model_provider to the custom provider
if [ -n "${OPENAI_API_KEY:-}" ]; then
    # Prepend to arguments -c model_provider=Custom -c model_providers.Custom.name=OpenAI -c model_providers.Custom.wire_api=responses -c model_providers.Custom.base_url=$OPENAI_BASE_URL -c model_providers.Octopus.env_key=OPENAI_API_KEY
	echo "Using endpoint: ${OPENAI_BASE_URL:-https://api.openai.com/v1} with model provider Custom"
	set -- -c model_provider=Custom -c model_providers.Custom.name=OpenAI -c model_providers.Custom.wire_api=responses -c model_providers.Custom.base_url="${OPENAI_BASE_URL:-https://api.openai.com/v1}" -c model_providers.Custom.env_key=OPENAI_API_KEY "$@"
fi

codex "$@"


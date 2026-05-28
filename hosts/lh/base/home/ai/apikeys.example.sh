export API_TIMEOUT_MS=3000000
export CLAUDE_CODE_ATTRIBUTION_HEADER=0
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
export DISABLE_INSTALLATION_CHECKS=1
export ENABLE_TOOL_SEARCH=1

API_KEY=sk-111
BASE_URL=https://example.com

if [[ -n "${ANTHROPIC_AUTH_TOKEN:-}" ]]; then
    echo "Using custom auth token"
else
    export ANTHROPIC_AUTH_TOKEN="$API_KEY"
    export ANTHROPIC_BASE_URL="$BASE_URL"
fi

case ${CC_PROFILE:-} in
ds|ds-pro)
	echo "Using profile DeepSeek V4 Pro"

	export ANTHROPIC_AUTH_TOKEN="$API_KEY"
	export ANTHROPIC_BASE_URL="$BASE_URL"

	export ANTHROPIC_DEFAULT_OPUS_MODEL="deepseek-v4-pro"
	export ANTHROPIC_DEFAULT_SONNET_MODEL="deepseek-v4-pro"
	export ANTHROPIC_DEFAULT_HAIKU_MODEL="deepseek-v4-pro"
	export ENABLE_TOOL_SEARCH=0

	set -- --model deepseek-v4-pro "$@"
	;;
glm)
	echo "Using profile GLM 5.1"

	export ANTHROPIC_AUTH_TOKEN="$API_KEY"
	export ANTHROPIC_BASE_URL="$BASE_URL"

	export ANTHROPIC_DEFAULT_OPUS_MODEL="glm-5.1"
	export ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.7"
	export ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air"
	export ENABLE_TOOL_SEARCH=0

	set -- --model "glm-5.1" "$@"
	;;
*)
	echo "Unknown profile"
	exit 1
	;;
esac


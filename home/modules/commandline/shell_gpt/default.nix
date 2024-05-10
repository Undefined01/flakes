{ inputs, pkgs, config, ... }:

{
  secret.secrets.openai-api.file = ../../../secrets/common.age;

  secret.secrets.openai-api.updateService = {
    runtimeInputs = with pkgs; [ jq ];
    script = ''
      mkdir -p ${config.home.homeDirectory}/.config/shell_gpt
      OPENAI_API_KEY=$(jq --raw-output '.openai_api.api_key' ${config.secret.secrets.openai-api.path})
      API_BASE_URL=$(jq --raw-output '.openai_api.base_url' ${config.secret.secrets.openai-api.path})
      cat <<EOF > ${config.home.homeDirectory}/.config/shell_gpt/.sgptrc
      OPENAI_API_KEY=''${OPENAI_API_KEY}
      API_BASE_URL=''${API_BASE_URL}
      CHAT_CACHE_LENGTH=100
      CHAT_CACHE_PATH=/tmp/chat_cache
      CACHE_LENGTH=100
      CACHE_PATH=/tmp/cache
      REQUEST_TIMEOUT=5
      DEFAULT_MODEL=gpt-3.5-turbo
      DEFAULT_COLOR=magenta
      DEFAULT_EXECUTE_SHELL_CMD=false
      DISABLE_STREAMING=false
      CODE_THEME=default
      SHOW_FUNCTIONS_OUTPUT=false
      OPENAI_USE_FUNCTIONS=true
      USE_LITELLM=false
      EOF
      chmod 600 ${config.home.homeDirectory}/.config/shell_gpt/.sgptrc
      exit 0
    '';
  };

  home.packages = with pkgs; [
    shell_gpt
  ];
}

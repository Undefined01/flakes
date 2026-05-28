{
  config,
  pkgs,
  lib,
  ...
}:

let
  claude = pkgs.pnpmCli.override {
    name = "claude";
    npmPkgName = "@anthropic-ai/claude-code";
  };

  apiKeysPath = lib.attrByPath [
    "sops"
    "secrets"
    "ai_api_keys"
    "path"
  ] "$HOME/.config/claude/api_keys" config;

  wrapped = pkgs.writeShellScriptBin "claude" ''
    export CLAUDE_CODE="''${CLAUDE_CODE:-${claude}/bin/claude}"
    export CC_APIKEY_SH="''${CC_APIKEY_SH:-${apiKeysPath}}"
    exec ${./claude.sh} "$@"
  '';
in
{
  options.custom.home.stacks.commandline.claudecode = {
    enable = lib.mkEnableOption "Enable claudecode.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.claudecode.enable {
    home.packages = [
      wrapped
    ];

    home.file.".config/ccstatusline/settings.json".source = ./ccstatusline.json;
  };
}

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
in
{
  options.custom.home.stacks.commandline.claudecode = {
    enable = lib.mkEnableOption "Enable claudecode.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.claudecode.enable {
    home.packages = [
      claude
    ];

    home.file.".config/ccstatusline/settings.json".source = ./ccstatusline.json;
  };
}

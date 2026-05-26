{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkDefault
    mkEnableOption
    mkIf
    mkOption
    types
    ;
in
{
  imports = [
    ../desktop/aerospace
    ../desktop/wezterm
    ../desktop/vscode
    ../desktop/firefox
    ../desktop/thunderbird
    ../desktop/zotero
  ];

  options.custom.home = {
    profiles.darwin = {
      enable = mkEnableOption "Enable the darwin home profile.";
      packages = mkOption {
        type = types.listOf types.package;
        default = with pkgs; [
          raycast
          keka
          sparkle

          qq
          wechat
        ];
        description = "Default packages for the darwin profile.";
      };
    };
  };

  config =
    let
      cfg = config.custom.home;
    in
    mkIf cfg.profiles.darwin.enable {
      custom.home.stacks.base.enable = mkDefault true;

      custom.home.stacks.desktop.aerospace.enable = mkDefault true;
      custom.home.stacks.desktop.wezterm.enable = mkDefault true;
      custom.home.stacks.desktop.vscode.enable = mkDefault true;
      custom.home.stacks.desktop.firefox.enable = mkDefault true;
      custom.home.stacks.desktop.thunderbird.enable = mkDefault true;
      custom.home.stacks.desktop.zotero.enable = mkDefault true;

      home.packages = cfg.profiles.darwin.packages;
    };
}

{ config, lib, pkgs, ... }:

let
  inherit (lib) mkDefault mkEnableOption mkIf mkOption types;
in
{
  imports = [
    ./hyprland
    ./mako
    ./waybar
    ./input
    ./foot
    ./wezterm
    ./vscode
    ./firefox
    ./thunderbird
    ./zotero
    ./obsidian
    ./obs
    ./clash-verge-rev
    ./eww
    ./wpsoffice
  ];

  options.custom.home = {
    profiles.desktop = {
      enable = mkEnableOption "Enable the desktop home profile.";
      packages = mkOption {
        type = types.listOf types.package;
        default = with pkgs; [
          polkit

          sparkle

          localsend
          qq
          wechat
        ];
        description = "Default packages for the desktop profile.";
      };
    };

    stacks.desktop = {
      terminal.variant = mkOption {
        type = types.enum [ "foot" "wezterm" "both" "none" ];
        default = "none";
        description = "Preferred terminal variant.";
      };
    };
  };

  config =
    let
      cfg = config.custom.home;
    in
    mkIf cfg.profiles.desktop.enable {
      custom.home.stacks.desktop.terminal.variant = mkDefault "both";

      custom.home.stacks.desktop.foot.enable = mkDefault (
        let v = cfg.stacks.desktop.terminal.variant; in v == "foot" || v == "both"
      );
      custom.home.stacks.desktop.wezterm.enable = mkDefault (
        let v = cfg.stacks.desktop.terminal.variant; in v == "wezterm" || v == "both"
      );

      custom.home.stacks.desktop.hyprland.enable = mkDefault true;
      custom.home.stacks.desktop.mako.enable = mkDefault true;
      custom.home.stacks.desktop.waybar.enable = mkDefault true;
      custom.home.stacks.desktop.input.enable = mkDefault true;

      custom.home.stacks.desktop.vscode.enable = mkDefault true;
      custom.home.stacks.desktop.firefox.enable = mkDefault true;
      custom.home.stacks.desktop.thunderbird.enable = mkDefault true;
      custom.home.stacks.desktop.zotero.enable = mkDefault true;
      custom.home.stacks.desktop.obsidian.enable = mkDefault true;
      custom.home.stacks.desktop.obs.enable = mkDefault true;

      home.packages = cfg.profiles.desktop.packages;
    };
}
{
  config,
  lib,
  pkgs,
  isLinux,
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
  imports = lib.optionals isLinux [
    ../desktop/wayland
    ../desktop/hyprland
    ../desktop/sway
    ../desktop/thunar
    ../desktop/input
    ../desktop/clash-verge
  ];

  options.custom.system = {
    profiles.desktop = {
      enable = mkEnableOption "Enable the desktop system profile.";
      packages = mkOption {
        type = types.listOf types.package;
        default = with pkgs; [
          vlc
        ];
        description = "Default packages for the desktop profile.";
      };
    };

    stacks.desktop = {
      wayland.enable = mkEnableOption "Enable Wayland configuration.";
      hyprland.enable = mkEnableOption "Enable Hyprland configuration.";
      sway.enable = mkEnableOption "Enable Sway configuration.";
      thunar.enable = mkEnableOption "Enable Thunar configuration.";
      input.enable = mkEnableOption "Enable input method configuration.";
      clashVerge.enable = mkEnableOption "Enable Clash Verge configuration.";
    };

    stacks.hardware = {
      audio.enable = mkEnableOption "Enable audio configuration.";
      bluetooth.enable = mkEnableOption "Enable Bluetooth configuration.";
      nvidia.enable = mkEnableOption "Enable Nvidia configuration.";
    };

    stacks.homebrew.enable = mkEnableOption "Enable Homebrew integration.";
    stacks.impermanence.enable = mkEnableOption "Enable impermanence.";
  };

  config =
    let
      cfg = config.custom.system;
    in
    mkIf cfg.profiles.desktop.enable {
      custom.system.profiles.commandline.enable = mkDefault true;

      custom.system.stacks.desktop.wayland.enable = mkDefault true;
      custom.system.stacks.desktop.hyprland.enable = mkDefault true;
      custom.system.stacks.desktop.thunar.enable = mkDefault true;
      custom.system.stacks.desktop.input.enable = mkDefault true;
      custom.system.stacks.desktop.clashVerge.enable = mkDefault true;

      custom.system.stacks.hardware.audio.enable = mkDefault true;
      custom.system.stacks.hardware.bluetooth.enable = mkDefault true;

      environment.systemPackages = cfg.profiles.desktop.packages;
    };
}

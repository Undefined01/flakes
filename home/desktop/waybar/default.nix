{ config, lib, ... }:

{
  options.custom.home.stacks.desktop.waybar = {
    enable = lib.mkEnableOption "Enable Waybar configuration.";
  };

  config = lib.mkIf config.custom.home.stacks.desktop.waybar.enable {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = import ./config.nix;
      style = builtins.readFile ./style.css;
    };
  };
}

{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf config.custom.system.stacks.desktop.sway.enable {
    environment.systemPackages = with pkgs; [
      clipman
      pamixer
      brightnessctl
    ];

    programs.sway.enable = true;

    environment.etc."sway/config.d/scale".source = ./sway.config;
  };
}

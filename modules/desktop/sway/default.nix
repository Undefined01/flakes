{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    clipman
    pamixer
  ];

  programs.sway.enable = true;

  environment.etc."sway/config.d/scale".source = ./sway.config;
}

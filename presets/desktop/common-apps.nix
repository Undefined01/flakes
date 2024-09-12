{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vlc
  ];

  programs.thunar.enable = true;
  services.tumbler.enable = true;
  services.gvfs.enable = true;
}

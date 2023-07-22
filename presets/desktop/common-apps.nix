{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    vscode
    vlc
  ];

  programs.thunar.enable = true;
  services.tumbler.enable = true;
  services.gvfs.enable = true;
}

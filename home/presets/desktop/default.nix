{ pkgs, ... }:

{
  imports = [
    ../../modules/desktop/hyprland
    ../../modules/desktop/mako
    # ../../modules/desktop/eww
    ../../modules/desktop/waybar

    ../../modules/desktop/foot
    ../../modules/desktop/wezterm
    ../../modules/desktop/vscode
    # ../../modules/desktop/wpsoffice
    ../../modules/desktop/firefox
    ../../modules/desktop/thunderbird
  ];

  home.packages = with pkgs; [
    clash-verge-rev
    localsend
  ];
}

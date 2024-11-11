{ pkgs, ... }:

{
  imports = [
    ../../modules/desktop/hyprland
    ../../modules/desktop/mako
    # ../../modules/desktop/eww
    ../../modules/desktop/waybar
    ../../modules/desktop/input

    ../../modules/desktop/clash-verge-rev
    ../../modules/desktop/foot
    ../../modules/desktop/wezterm
    ../../modules/desktop/vscode
    # ../../modules/desktop/wpsoffice
    ../../modules/desktop/firefox
    ../../modules/desktop/thunderbird
  ];

  home.packages = with pkgs; [
    polkit # for pkexec, used by clash-verge-rev

    localsend
    obs-studio
    qq
    nur.repos.novel2430.wechat-universal-bwrap
  ];
}

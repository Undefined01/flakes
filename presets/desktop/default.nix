{ ... }:

{
  imports = [
    ../commandline

    ../../modules/desktop/wayland
    ../../modules/desktop/hyprland
    ../../modules/desktop/thunar
    ../../modules/hardware
    ../../modules/font
    ./common-apps.nix
  ];
}

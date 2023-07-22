{ ... }:

{
  imports = [
    ../minimal
    ../commandline

    ../../modules/desktop/sway
    ../../modules/desktop/wayland
    ../../modules/hardware
    ../../modules/font
    ../../modules/input
    ./common-apps.nix
  ];
}

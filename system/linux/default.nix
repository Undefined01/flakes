{ ... }:

{
  imports = [
    ../desktop/wayland
    ../desktop/hyprland
    ../desktop/sway
    ../desktop/thunar
    ../desktop/input
    ../desktop/clash-verge
    ../hardware/audio.nix
    ../hardware/bluetooth.nix
    ../hardware/nvidia.nix
    ../impermanence
    ../base/console
  ];
}
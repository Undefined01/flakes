{ ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = import ./config.nix;
    style = builtins.readFile ./style.css;
  };
}

{ pkgs, ... }:

{
  imports = [
    ./preferences.nix
    ../../modules/desktop/aerospace
    ../../modules/desktop/wezterm
    ../../modules/desktop/vscode
  ];
}

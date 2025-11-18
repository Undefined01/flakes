{ pkgs, ... }:

{
  imports = [
    ../../modules/misc

    ./preferences.nix

    ../../modules/desktop/aerospace
    ../../modules/desktop/wezterm
    ../../modules/desktop/vscode
    ../../modules/desktop/zotero
    ../../modules/desktop/thunderbird

    # Does not support aarch64-darwin yet
    # ../../modules/desktop/obsidian
    # ../../modules/desktop/obs
  ];

  home.packages = with pkgs; [
    raycast
    keka
  ];
}

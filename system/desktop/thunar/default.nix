{ config, pkgs, lib, ... }:

{
  config = lib.mkIf config.custom.system.stacks.desktop.thunar.enable {
    programs.thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];
    };

    # File preview, mounts, and trash integration for Thunar.
    services.tumbler.enable = true;
    services.gvfs.enable = true;
  };
}

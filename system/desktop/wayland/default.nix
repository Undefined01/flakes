{
  config,
  pkgs,
  user,
  inputs,
  lib,
  ...
}:

{
  config = lib.mkIf config.custom.system.stacks.desktop.wayland.enable {
    programs = {
      dconf.enable = true;
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-wlr
      ];
    };
  };
}

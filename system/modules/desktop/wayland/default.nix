{ config, pkgs, user, inputs, lib, ... }:

{
  programs = {
    dconf.enable = true;
    light.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
  };
}

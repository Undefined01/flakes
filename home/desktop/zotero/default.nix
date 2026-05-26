{ config, pkgs, lib, ... }:

{
  options.custom.home.stacks.desktop.zotero = {
    enable = lib.mkEnableOption "Enable Zotero configuration.";
  };

  config = lib.mkIf config.custom.home.stacks.desktop.zotero.enable {
    home.packages = with pkgs; [
      zotero
    ];
  };
}

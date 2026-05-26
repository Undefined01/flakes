{ config, pkgs, lib, ... }:

{
  options.custom.home.stacks.desktop.wpsOffice = {
    enable = lib.mkEnableOption "Enable WPS Office configuration.";
  };

  config = lib.mkIf config.custom.home.stacks.desktop.wpsOffice.enable {
    home.packages = [
      pkgs.wpsoffice
    ];
  };
}

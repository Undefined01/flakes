{ config, lib, ... }:

{
  options.custom.home.stacks.desktop.mako = {
    enable = lib.mkEnableOption "Enable mako notifications.";
  };

  config = lib.mkIf config.custom.home.stacks.desktop.mako.enable {
    services.mako = {
      enable = true;
    };
  };
}

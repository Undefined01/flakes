{ config, lib, ... }:

{
  options.custom.home.stacks.commandline.tealdeer = {
    enable = lib.mkEnableOption "Enable tealdeer.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.tealdeer.enable {
    programs.tealdeer = {
      enable = true;
      settings.updates = {
        auto_update = false;
        auto_update_interval_hours = 7 * 24;
      };
    };
  };
}

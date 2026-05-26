{ config, lib, ... }:

{
  options.custom.home.stacks.desktop.thunderbird = {
    enable = lib.mkEnableOption "Enable Thunderbird configuration.";
  };

  config = lib.mkIf config.custom.home.stacks.desktop.thunderbird.enable {
    programs.thunderbird = {
      enable = true;
      profiles.lh = {
        isDefault = true;
      };
    };
  };
}

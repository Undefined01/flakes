{ config, lib, ... }:

{
  options.custom.home.stacks.desktop.obs = {
    enable = lib.mkEnableOption "Enable OBS configuration.";
  };

  config = lib.mkIf config.custom.home.stacks.desktop.obs.enable {
    programs.obs-studio = {
      enable = true;
    };
  };
}

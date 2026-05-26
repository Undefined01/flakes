{ config, lib, ... }:

{
  options.custom.home.stacks.commandline.lsd = {
    enable = lib.mkEnableOption "Enable lsd.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.lsd.enable {
    programs.lsd = {
      enable = true;
      enableBashIntegration = false;
      enableFishIntegration = false;
      enableZshIntegration = false;
    };
  };
}

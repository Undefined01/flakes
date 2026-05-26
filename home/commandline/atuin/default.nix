{ config, lib, ... }:

{
  options.custom.home.stacks.commandline.atuin = {
    enable = lib.mkEnableOption "Enable atuin.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.atuin.enable {
    programs.atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
    };
  };
}

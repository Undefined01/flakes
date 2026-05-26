{ config, lib, ... }:

{
  options.custom.home.stacks.commandline.zoxide = {
    enable = lib.mkEnableOption "Enable zoxide.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.zoxide.enable {
    programs.zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };
}

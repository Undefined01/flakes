{ config, lib, ... }:

{
  config = lib.mkIf config.custom.system.stacks.desktop.clashVerge.enable {
    programs.clash-verge = {
      enable = true;
      autoStart = true;
    };
  };
}
{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf mkOption types;
in
{
  imports = [
    ./misc
  ];

  options.custom.home.stacks.base = {
    enable = mkEnableOption "Enable the base home stack.";
  };

  config = mkIf config.custom.home.stacks.base.enable { };
}

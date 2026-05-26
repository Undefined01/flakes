{ config, lib, pkgs, ... }:

let
  inherit (lib) mkDefault mkEnableOption mkIf mkOption types;
in
{
  imports = [
    ./misc
    ./nix
    ./user
  ];

  options.custom.system.profiles.minimal = {
    enable = mkEnableOption "Enable the minimal system profile.";
    packages = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        git
        vim
        wget
        curl
      ];
      description = "Default packages for the minimal profile.";
    };
  };

  config =
    let
      cfg = config.custom.system;
    in
    mkIf cfg.profiles.minimal.enable {
      custom.system.stacks.base.misc.enable = mkDefault true;
      custom.system.stacks.base.nix.enable = mkDefault true;
      custom.system.stacks.base.user.enable = mkDefault true;

      environment.systemPackages = cfg.profiles.minimal.packages;
    };
}
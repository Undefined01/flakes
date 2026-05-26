{
  config,
  lib,
  pkgs,
  isLinux,
  ...
}:

let
  inherit (lib)
    mkDefault
    mkEnableOption
    mkIf
    mkOption
    types
    ;
in
{
  imports = [
    ./console
    ./misc
    ./nix
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
      custom.system.stacks.base.console.enable = mkDefault isLinux;

      environment.systemPackages = cfg.profiles.minimal.packages;
    };
}

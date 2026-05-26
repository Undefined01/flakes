{
  config,
  inputs,
  pkgs,
  lib,
  customLib,
  ...
}:

{
  imports = [
    inputs.mutable-home-files.homeManagerModules.default
  ];

  config = lib.mkIf config.custom.home.stacks.base.enable {
    nixpkgs.overlays = builtins.attrValues (import (customLib.fromFlakeRoot "overlays") { inherit inputs; });
    nixpkgs.config = import ./nixpkgs-config.nix;
    xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;

    nix = {
      registry = {
        nixpkgs.flake = inputs.nixpkgs;
        unstable.to = {
          "type" = "github";
          "owner" = "NixOS";
          "repo" = "nixpkgs";
          "ref" = "nixos-unstable";
        };
        nur.flake = inputs.nur;
      };
    };

    home.sessionVariables = {
      PAGER = "less -FirSwX";
    };

    # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.05";
  };
}

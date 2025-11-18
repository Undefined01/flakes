{ inputs, pkgs, user, ... }:

{
  nixpkgs.overlays = builtins.attrValues (import ../../overlays { inherit inputs; });
  nixpkgs.config.allowUnfree = true;

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
}

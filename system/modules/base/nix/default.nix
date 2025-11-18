{ pkgs, lib, inputs, user, ... }:

{
  nix = {
    settings = {
      trusted-users = [ "@admin" "@sudo" "@wheel" "${user}" ];
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    # Collect garbage periodically
    gc =
      let
        periodConfig = lib.optionalAttrs pkgs.stdenv.isLinux
          {
            dates = "daily";
          } // lib.optionalAttrs pkgs.stdenv.isDarwin {
          interval = { Weekday = 1; Hour = 0; Minute = 0; };
        };
      in
      {
        automatic = true;
        options = "--delete-older-than 30d";
      } // periodConfig;

    # Optimise nix store via hardlinking
    optimise.automatic = true;

    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      unstable.flake = inputs.nixpkgs-unstable;
      # unstable.to = {
      #   "type" = "github";
      #   "owner" = "NixOS";
      #   "repo" = "nixpkgs";
      #   "ref" = "nixos-unstable";
      # };
      nur.flake = inputs.nur;
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = builtins.attrValues (import ../../../../overlays { inherit inputs; });
  };
}

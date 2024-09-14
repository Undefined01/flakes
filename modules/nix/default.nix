{ pkgs, lib, inputs, user, ... }:

{
  # enable flakes globally
  nix.settings = {
    trusted-users = [ user ];
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" "https://nix-community.cachix.org" "https://cache.nixos.org/" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Add overlays
  nixpkgs.overlays = builtins.attrValues (import ../../overlays { inherit inputs; });

  # do garbage collection daily to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  } // lib.optionalAttrs pkgs.stdenv.isLinux {
    dates = "daily";
  } // lib.optionalAttrs pkgs.stdenv.isDarwin {
    interval = lib.mkDefault { Weekday = 1; Hour = 0; Minute = 0; };
  };

  # optimise nix store via hardlinking
  nix.optimise.automatic = lib.mkDefault true;
}

{ pkgs, lib, user, ... }:

{
  # Auto upgrade nix package and the daemon service.

  nix.package = pkgs.nix;

  nix = {
    settings = {
      trusted-users = [ "@admin" user ];
    };
  };
}

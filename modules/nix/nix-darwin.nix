{ pkgs, lib, ... }:

{
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # Use this instead of services.nix-daemon.enable if you
  # don't wan't the daemon service to be managed for you.
  # nix.useDaemon = true;

  nix.package = pkgs.nix;

  nix = {
    settings = {
      trusted-users = [ "@admin" "${user}" ];
    };
  };
}

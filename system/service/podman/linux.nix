{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf config.custom.system.stacks.service.podman.enable {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      autoPrune = {
        enable = true;
      };
    };

    environment.systemPackages = [
      pkgs.buildah
      pkgs.podman-compose
    ];
  };
}

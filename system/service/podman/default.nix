{ lib, isLinux, ... }:

{
  imports = lib.optionals isLinux [ ./linux.nix ];

  options.custom.system.stacks.service.podman = {
    enable = lib.mkEnableOption "Enable Podman service.";
  };
}

{ lib, isLinux, ... }:

{
  imports = lib.optionals isLinux [ ./linux.nix ];

  options.custom.system.stacks.service.ssh = {
    enable = lib.mkEnableOption "Enable OpenSSH service.";
  };
}

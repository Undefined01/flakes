{ lib, isLinux, ... }:

{
  imports = lib.optionals isLinux [ ./linux.nix ];

  options.custom.system.stacks.service.zerotierone = {
    enable = lib.mkEnableOption "Enable Zerotier service.";
  };
}

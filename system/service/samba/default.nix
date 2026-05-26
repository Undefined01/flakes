{ lib, isLinux, ... }:

{
  imports = lib.optionals isLinux [ ./linux.nix ];

  options.custom.system.stacks.service.samba = {
    enable = lib.mkEnableOption "Enable Samba service.";
  };
}

{ lib, isLinux, ... }:

{
  imports = lib.optionals isLinux [ ./linux.nix ];

  options.custom.system.stacks.service.cloudflared = {
    enable = lib.mkEnableOption "Enable Cloudflared service.";
  };
}

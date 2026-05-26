{ config, lib, ... }:

{
  config = lib.mkIf config.custom.system.stacks.base.misc.enable {
    # Allow sudo authentication with Touch ID
    security.pam.services.sudo_local.touchIdAuth = true;
  };
}

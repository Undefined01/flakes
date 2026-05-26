{ config, lib, ... }:

{
  config = lib.mkIf config.custom.system.stacks.hardware.bluetooth.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}

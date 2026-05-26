{ config, lib, ... }:

{
  config = lib.mkIf config.custom.system.stacks.hardware.audio.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # recommended on NixOS Wiki
    security.rtkit.enable = true;
  };
}

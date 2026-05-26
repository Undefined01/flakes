{ config, lib, ... }:

{
  config = lib.mkIf config.custom.system.stacks.service.zerotierone.enable {
    services.zerotierone = {
      enable = true;
      joinNetworks = [
        "0cccb752f7ddae0b"
      ];
    };
  };
}

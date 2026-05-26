{ config, lib, ... }:

{
  options.custom.home.stacks.commandline.gpgAgent = {
    enable = lib.mkEnableOption "Enable gpg-agent.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.gpgAgent.enable {
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableExtraSocket = true;
    };
  };
}

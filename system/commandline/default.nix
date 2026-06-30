{
  config,
  lib,
  isLinux,
  ...
}:

let
  inherit (lib) mkDefault mkEnableOption mkIf;
in
{
  imports = [
    ../service/ssh
    ../service/podman
    ../service/zerotierone
    ../service/easytier
    ../service/cloudflared
    ../service/samba
  ];

  options.custom.system = {
    profiles.commandline.enable = mkEnableOption "Enable the commandline system profile.";
  };

  config =
    let
      cfg = config.custom.system;
    in
    mkIf cfg.profiles.commandline.enable {
      custom.system.profiles.minimal.enable = mkDefault true;

      custom.system.stacks.service.ssh.enable = mkDefault true;
      custom.system.stacks.service.podman.enable = mkDefault true;
      custom.system.stacks.service.zerotierone.enable = mkDefault false;
      custom.system.stacks.service.easytier.enable = mkDefault false;
      custom.system.stacks.service.cloudflared.enable = mkDefault false;
      custom.system.stacks.service.samba.enable = mkDefault false;
    };
}

{ pkgs, ... }:

{
  imports = [
    ../minimal

    ./common.nix
    ../../modules/commandline/ssh
    ../../modules/commandline/podman
    ../../modules/commandline/console
    ../../modules/commandline/zerotierone
    ../../modules/commandline/easytier
    ../../modules/commandline/cloudflared

    ../../modules/samba
  ];
}

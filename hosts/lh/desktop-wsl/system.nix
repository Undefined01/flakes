{ config, inputs, ... }:

let
  meta = import ./meta.nix;
in
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl

    ../base/system
  ];

  custom.system.profiles.commandline.enable = true;

  custom.system.users.${meta.username} = {
    name = meta.username;
    authorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDcTQOKYRyLoviozP5Ba6k8N+1Sn7LZ1wECHiPa2FF1V amoscr@163.com"
    ];
    homeConfiguration = ./home.nix;
  };

  wsl.enable = true;
  wsl.defaultUser = meta.username;

  wsl.docker-desktop.enable = false;
  wsl.usbip.enable = false;

  nixpkgs.hostPlatform = meta.platform;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # it at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

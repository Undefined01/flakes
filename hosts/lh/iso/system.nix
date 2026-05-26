{ inputs, ... }:

let
  meta = import ./meta.nix;
in
{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  custom.system.profiles.commandline.enable = true;

  custom.system.users.${meta.username} = {
    name = meta.username;
    authorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDcTQOKYRyLoviozP5Ba6k8N+1Sn7LZ1wECHiPa2FF1V amoscr@163.com"
    ];
  };

  custom.system.host.primaryUser = meta.username;

  nixpkgs.hostPlatform = meta.platform;

  # isoImage.squashfsCompression = "xz -Xdict-size 100%"; # default 2.9G
  # isoImage.squashfsCompression = "gzip -Xcompression-level 1";
  # isoImage.squashfsCompression = "zstd -b 32768 -Xcompression-level 22"; # 3.5G
}

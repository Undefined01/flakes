{ inputs, ... }:

{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"

    ../base/system
  ];

  custom.system.profiles.commandline.enable = true;

  # isoImage.squashfsCompression = "xz -Xdict-size 100%"; # default 2.9G
  # isoImage.squashfsCompression = "gzip -Xcompression-level 1";
  # isoImage.squashfsCompression = "zstd -b 32768 -Xcompression-level 22"; # 3.5G
}

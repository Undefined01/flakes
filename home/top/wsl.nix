{ user, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./presets/commandline
  ];
}

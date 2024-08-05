{ inputs, outputs, lib, config, pkgs, user, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in
{
  imports = [
    # ./modules/sops
    ./modules/agenix

    ./presets/commandline
    ./presets/desktop
    ./presets/programming
  ];

  nixpkgs.overlays = builtins.attrValues ((import ../overlays { inherit inputs; }) // (import ./overlays { inherit inputs; }));
  nixpkgs.config.allowUnfreePredicate = p: true;

  home.sessionVariables = {
    PAGER = "less -FirSwX";
  };

  systemd.user.startServices = "sd-switch";

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}

{ inputs, outputs, lib, config, pkgs, user, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  # For our MANPAGER env var
  # https://github.com/sharkdp/bat/issues/1145
  manpager = (pkgs.writeShellScriptBin "manpager" (if isDarwin then ''
    sh -c 'col -bx | bat -l man -p'
  '' else ''
    col -bx < "$1" | bat --language man -p
  ''));
in
{
  imports = [
    # ./modules/sops
    ./modules/agenix

    ./modules/git
    ./modules/ssh
    ./modules/direnv
    ./modules/shell_gpt
  ];

  nixpkgs.overlays = builtins.attrValues (import ./overlays { inherit inputs; });

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
    PAGER = "less -FirSwX";
    MANPAGER = "${manpager}/bin/manpager";
  };

  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}

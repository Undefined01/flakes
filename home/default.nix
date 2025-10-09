{ user, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./presets/commandline
    ./presets/desktop
  ];

  home.username = user;
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${user}" else "/home/${user}";
}

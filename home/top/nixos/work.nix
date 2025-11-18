{ user, pkgs, ... }:

{
  imports = [
    ../../presets/commandline
    ../../presets/desktop
  ];

  # home.username = pkgs.lib.mkDefault user;
  # home.homeDirectory = pkgs.lib.mkDefault (
  #   if pkgs.stdenv.isDarwin
  #   then "/Users/${user}"
  #   else "/home/${user}"
  # );
}

{ pkgs, ... }:

{
  imports = [
    ../base/home
  ];

  custom.home.profiles.darwin.enable = true;
}

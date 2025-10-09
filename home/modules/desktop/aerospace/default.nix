{ pkgs, ... }:

{
  imports = [
    ./preferences-fix.nix
  ];

  programs.aerospace = {
    enable = true;
    launchd.enable = true;
    userSettings = {
      default-root-container-layout = "accordion";
      default-root-container-orientation = "auto";
      automatically-unhide-macos-hidden-apps = true;
      accordion-padding = 30;
    };
  };
}

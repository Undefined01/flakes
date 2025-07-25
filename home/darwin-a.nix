{ pkgs, ... }:

{
  imports = [
    ./common.nix
    ./presets/commandline
    ./presets/darwin
  ];

  home.packages = with pkgs; [
    kubectl
  ];

  programs.vscode = {
    profiles.default.userSettings = {
      "aoneCopilot.userToken" = "";
    };
  };
}

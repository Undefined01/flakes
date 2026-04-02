{ pkgs, ... }:

{
  imports = [
    ../../presets/commandline
    ../../presets/darwin
  ];

  home.packages = with pkgs; [
    kubectl
  ];

  git.signing.signByDefault = false;
  customize.vscode.extensions.exclude = [
    "wakatime.vscode-wakatime"
    "github.copilot"
    "github.copilot-chat"
  ];
}

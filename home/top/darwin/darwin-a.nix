{ pkgs, ... }:

{
  imports = [
    ../../presets/commandline
    ../../presets/darwin
  ];

  home.packages = with pkgs; [
    kubectl
  ];

  customize.git.signing.enable = false;
  customize.vscode.extensions.exclude = [
    "wakatime.vscode-wakatime"
    "github.copilot"
    "github.copilot-chat"
  ];
}

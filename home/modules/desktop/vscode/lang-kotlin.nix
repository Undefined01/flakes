{ pkgs, ... }:

{
  programs.vscode = {
    extensions = with pkgs.vscode-marketplace; [
      fwcd.kotlin
    ];

    userSettings = {
      "kotlin.scripts.buildScriptsEnabled" = true;

      "remote.SSH.defaultExtensions" = [
        "fwcd.kotlin"
      ];
    };
  };
}

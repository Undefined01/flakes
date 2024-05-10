{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      fwcd.kotlin
    ];

    user-settings = {
      "kotlin.scripts.buildScriptsEnabled" = true;
    }
      };
  }

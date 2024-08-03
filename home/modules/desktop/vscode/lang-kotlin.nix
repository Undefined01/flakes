{ pkgs, ... }:

{
  programs.vscode = {
    extensions = with pkgs.open-vsx-release; [
      fwcd.kotlin
    ];

    userSettings = {
      "kotlin.scripts.buildScriptsEnabled" = true;
    };
  };
}

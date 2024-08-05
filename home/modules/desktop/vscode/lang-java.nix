{ pkgs, ... }:

{
  programs.vscode = {
    extensions = with pkgs.open-vsx-release; [
      vscjava.vscode-java-pack
      vscjava.vscode-gradle
    ];

    userSettings = {
      "files.exclude" = {
        "**/.classpath" = true;
        "**/.factorypath" = true;
        "**/.project" = true;
        "**/.settings" = true;
      };
    };
  };
}

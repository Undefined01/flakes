{ pkgs, ... }:

{
  programs.vscode.profiles.default= {
    extensions = with pkgs.vscode-marketplace; [
      vscjava.vscode-java-pack
      redhat.java
      vscjava.vscode-gradle
      visualstudioexptteam.vscodeintellicode
      vscjava.vscode-java-debug
      vscjava.vscode-maven
      vscjava.vscode-java-test
      vscjava.vscode-java-dependency
    ];

    userSettings = {
      "files.exclude" = {
        "**/.classpath" = true;
        "**/.factorypath" = true;
        "**/.project" = true;
        "**/.settings" = true;
      };

      "remote.SSH.defaultExtensions" = [
        "vscjava.vscode-java-pack"
        "vscjava.vscode-gradle"
      ];
    };
  };
}

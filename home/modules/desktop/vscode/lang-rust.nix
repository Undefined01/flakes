{ pkgs, ... }:

{
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace; [
      rust-lang.rust-analyzer
    ];

    userSettings = {
      "[rust]" = {
        "editor.defaultFormatter" = "rust-lang.rust-analyzer";
      };
      "remote.SSH.defaultExtensions" = [
        "rust-lang.rust-analyzer"
      ];
    };
  };
}

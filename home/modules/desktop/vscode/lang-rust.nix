{ pkgs, ... }:

{
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace; [
      rust-lang.rust-analyzer
    ];

    userSettings = {
      "[python]" = {
        "editor.defaultFormatter" = "ms-python.black-formatter";
      };
      "remote.SSH.defaultExtensions" = [
        "rust-lang.rust-analyzer"
      ];
    };
  };
}

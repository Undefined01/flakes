{ pkgs, ... }:

{
  programs.vscode = {
    extensions = with pkgs.vscode-marketplace; [
      llvm-vs-code-extensions.vscode-clangd
      vadimcn.vscode-lldb
    ];

    userSettings = {
      "remote.SSH.defaultExtensions" = [
        "llvm-vs-code-extensions.vscode-clangd"
        "vadimcn.vscode-lldb"
      ];
    };
  };
}

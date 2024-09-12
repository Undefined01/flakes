{ pkgs, ... }:

{
  programs.vscode = {
    extensions = with pkgs.vscode-marketplace; [
      llvm-vs-code-extensions.vscode-clangd
      vadimcn.vscode-lldb
    ];
  };
}

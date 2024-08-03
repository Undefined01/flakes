{ pkgs, ... }:

{
  programs.vscode = {
    extensions = with pkgs.open-vsx-release; [
      llvm-vs-code-extensions.vscode-clangd
      vadimcn.vscode-lldb
    ];
  };
}

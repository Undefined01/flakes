{ pkgs, ... }:

{
  programs.vscode = {
    extensions = with pkgs.open-vsx-release; [
      rust-lang.rust-analyzer
    ];
  };
}

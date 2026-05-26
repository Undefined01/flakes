{ config, lib, pkgs, ... }:

let
  customPkgs = pkgs // {
    jdt-language-server = pkgs.unstable.jdt-language-server;
  };
in
{
  config = lib.mkIf config.custom.home.stacks.commandline.editor.lsp.enable {
    home.packages = with customPkgs; [
      bash-language-server
      lua-language-server
      # vscode-langservers-extracted
      # (python3.withPackages (python-pkgs: [
      #   python-pkgs.pandas
      #   python-pkgs.requests
      #   python-pkgs.python-lsp-server
      # ]))

      # clang
      # jdt-language-server
      # gopls
      # kotlin-language-server
      # # rust-analyzer
      # typescript-language-server

      # typst-lsp
    ];
  };
}

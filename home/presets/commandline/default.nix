{ pkgs, isWsl, ... }:

{
  imports = [
    ../../modules/git
    ../../modules/ssh
    ../../modules/bash
    ../../modules/fish
    ../../modules/zsh
    ../../modules/starship

    ../../modules/eza
    ../../modules/bat
    ../../modules/bottom
    ../../modules/tealdeer
    ../../modules/zoxide

    ../../modules/direnv
    ../../modules/neovim
    ../../modules/shell_gpt
  ];

  programs.fzf.enable = true;

  home.packages = with pkgs; [
    # busybox
    wget
    curl
    less
    man
    file
    zip
    unzip
    p7zip
    zstd
    vim

    gcc
    gnumake
    python3Minimal
    nodejs-slim

    gnupg
    age
    du-dust
    ripgrep
    fd
    jq
    tokei
    difftastic

    ntfs3g
  ] ++ lib.optionals isWsl [
    win32yank
  ];
}

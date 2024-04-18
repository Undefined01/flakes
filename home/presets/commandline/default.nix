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
    ../../modules/zoxide
    ../../modules/fd
    ../../modules/fzf
    ../../modules/gitui
    ../../modules/tealdeer

    ../../modules/direnv
    ../../modules/neovim
    ../../modules/shell_gpt
  ];

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
    jq
    sd
    tokei
    difftastic

    ntfs3g
  ] ++ lib.optionals isWsl [
    win32yank
  ];
}

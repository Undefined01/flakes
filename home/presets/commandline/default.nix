{ pkgs, isWsl, ... }:

{
  imports = [
    ../../modules/commandline/git
    ../../modules/commandline/ssh
    ../../modules/commandline/bash
    ../../modules/commandline/fish
    ../../modules/commandline/zsh
    ../../modules/commandline/starship

    ../../modules/commandline/eza
    ../../modules/commandline/bat
    ../../modules/commandline/bottom
    ../../modules/commandline/zoxide
    ../../modules/commandline/fd
    ../../modules/commandline/fzf
    ../../modules/commandline/gitui
    ../../modules/commandline/tealdeer

    ../../modules/commandline/direnv
    ../../modules/commandline/neovim
    ../../modules/commandline/shell_gpt
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
    openssl
    age

    du-dust
    ripgrep
    jq
    sd
    tokei
    difftastic

    ntfs3g
  ] ++ lib.optionals isWsl [
    # win32yank
  ];
}

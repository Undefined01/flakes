{ pkgs, ... }:

{
  imports = [
    ../../modules/misc

    ../../modules/commandline/git
    ../../modules/commandline/ssh
    ../../modules/commandline/bash
    ../../modules/commandline/fish
    ../../modules/commandline/zsh
    ../../modules/commandline/starship

    ../../modules/commandline/eza
    ../../modules/commandline/bat
    ../../modules/commandline/ls-or-cat
    ../../modules/commandline/bottom
    ../../modules/commandline/zoxide
    ../../modules/commandline/fd
    ../../modules/commandline/fzf
    ../../modules/commandline/gitui
    ../../modules/commandline/tealdeer
    ../../modules/commandline/atuin
    ../../modules/commandline/yazi

    ../../modules/commandline/uv
    ../../modules/commandline/direnv
    ../../modules/commandline/neovim
    ../../modules/commandline/rclone
  ];

  home.packages = with pkgs; [
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

    gnupg
    openssl
    age

    dust
    ripgrep
    jq
    sd
    tokei
    difftastic

    zellij
  ];
}

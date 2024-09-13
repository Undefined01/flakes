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
    ../../modules/commandline/atuin

    ../../modules/commandline/direnv
    ../../modules/commandline/neovim
    ../../modules/commandline/shell_gpt
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

    python3Minimal

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

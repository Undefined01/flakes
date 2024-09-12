{ pkgs, ... }:

{
  imports = [
    ../minimal

    ../../modules/commandline/console
    ../../modules/commandline/ssh
    ../../modules/commandline/podman
    ../../modules/commandline/zerotierone
  ];

  environment.systemPackages = with pkgs; [
    wget
    curl
    vim
    git
    less
    python3
    man
    gnutar
    zip
    unzip
    p7zip
    zstd
    killall

    delta
    eza
    bat
    tealdeer
    du-dust
    ripgrep
    fd
    jq
    fzf
    glances
    zoxide
    tokei
    difftastic

    ntfs3g

    zsh
    fish
    gnupg
    age
    chezmoi
  ];

  environment.sessionVariables = {
    EDITOR = "vim";
  };
}

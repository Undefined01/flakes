{ pkgs, ... }:

{
  imports = [
    ../minimal
  ];

  environment.systemPackages = with pkgs; [
    wget
    curl
    vim
    git
    less
    python3
    uv
    man
    gnutar
    zip
    unzip
    p7zip
    zstd
    killall

    eza
    bat
    tealdeer
    dust
    ripgrep
    fd
    jq
    fzf
    zoxide
    difftastic

    ntfs3g

    zsh
    fish
  ];

  # environment.sessionVariables = {
  #   EDITOR = "vim";
  # };
}

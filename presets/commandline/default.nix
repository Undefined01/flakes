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
    python3Minimal
    man
    gnutar
    zip
    unzip
    p7zip
    zstd

    tldr
    du-dust
    ripgrep
    fd
    jq
    fzf
    glances

    ntfs3g
  ];

  environment.sessionVariables = {
    EDITOR = "vim";
  };
}

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
    zip
    unzip
    p7zip

    tldr
    du-dust
    ripgrep
    fd
    jq
    fzf
    glances
  ];

  environment.sessionVariables = {
    EDITOR = "vim";
  };
}

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
    man
    gnutar
    zip
    unzip
    p7zip
    zstd
    killall

    delta
    exa
    bat
    tldr
    du-dust
    ripgrep
    fd
    jq
    fzf
    glances
    zoxide

    ntfs3g

    zsh
    fish
    gnupg
    chezmoi
  ];

  programs.fzf.keybindings = true;
  programs.fzf.fuzzyCompletion = true;

  environment.sessionVariables = {
    EDITOR = "vim";
  };
}

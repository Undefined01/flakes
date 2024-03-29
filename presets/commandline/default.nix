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
    eza
    bat
    tldr
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
    chezmoi

    shell_gpt
  ];

  programs.fzf.keybindings = true;
  programs.fzf.fuzzyCompletion = true;

  environment.sessionVariables = {
    EDITOR = "vim";
  };
}

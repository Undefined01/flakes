{ ... }:

{
  programs.eza = {
    enable = true;
    git = true;
    icons = true;
  };

  home.shellAliases = {
    ls = "eza --color=auto";
    ll = "eza --color=auto --color-scale all --long --all --extended";
    tree = "eza --color=auto --tree";
  };

  programs.fzf = {
    changeDirWidgetOptions = [ "--preview 'eza --color=always --tree --icons {} | head -200'" ];
  };
}

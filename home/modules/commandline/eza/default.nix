{ ... }:

{
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
  };

  home.shellAliases = {
    ls = "eza --color=auto";
    ll = "eza --color=auto --color-scale all --long --all --extended";
    tree = "eza --color=auto --tree";
  };
}

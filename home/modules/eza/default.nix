{ ... }:

{
  programs.eza = {
    enable = true;
    git = true;
    icons = true;
  };

  home.shellAliases = {
    ls = "eza --color=auto";
    ll = "eza --color=auto --long --all --color-scale all --extended";
  };
}

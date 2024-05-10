{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep ];
  };

  home.shellAliases = {
    bat = "batdiff";
    man = "batman";
    grep = "batgrep";
  };
}

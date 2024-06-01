{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep ];
  };

  home.shellAliases = {
    cat = "bat";
    diff = "batdiff";
    man = "batman";
    grep = "batgrep";
  };
}

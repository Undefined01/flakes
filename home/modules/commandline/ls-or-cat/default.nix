{
  pkgs,
  lib,
  config,
  ...
}:

let
  getOrDefault =
    set: attr: default:
    if set ? attr then set.${attr} else default;
  ls = getOrDefault config.home.shellAliases "ls" "ls";
  cat = getOrDefault config.home.shellAliases "cat" "cat";

  # ls = lib.getExe pkgs.eza;
  # cat = lib.getExe pkgs.bat;

  ls-or-cat = pkgs.writeShellScriptBin "ls-or-cat" ''
    if [ $# -eq 0 ]; then
      ${ls}
    else
      while [ $# -gt 0 ]; do
        if [ -d "$1" ]; then
          ${ls} "$1"
        elif [ -f "$1" ]; then
          ${cat} "$1"
        else
          echo "error: '$1' is neither a file nor a directory" >&2
          return 1
        fi
        shift
      done
    fi
  '';
in
{
  home.packages = [ ls-or-cat ];

  home.shellAliases = {
    l = "ls-or-cat";
  };
}

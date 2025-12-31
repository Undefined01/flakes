{ pkgs, lib, config, ... }:

let
  # getOrDefault = set: attr: default: if set ? attr then set.${attr} else default;
  # ls = getOrDefault config.home.shellAliases "ls" "ls";
  # cat = getOrDefault config.home.shellAliases "cat" "cat";

  ls = pkgs.eza;
  cat = pkgs.bat;

  ls-or-cat1 = pkgs.writeScript "ls-or-cat" ''
    #/usr/bin/env bash

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
  ls-or-cat = lib.traceVal "${ls-or-cat1}";
in
{
  home.shellAliases = {
    ls-or-cat = ls-or-cat;
    l = ls-or-cat;
  };
}

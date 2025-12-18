{ pkgs, final ? pkgs, prev ? pkgs }:

let
  # Copy from pkgs.lib to prevent infinite recursion on pkgs
  filterAttrs = pred: set: removeAttrs set (builtins.filter (name: !pred name set.${name}) (builtins.attrNames set));

  dirContents =
    filterAttrs (k: v: v == "directory") (builtins.readDir ./.);
  callPackage = pkgs.lib.callPackageWith (pkgs // { inherit final prev; });
  genPackage = name: {
    inherit name;
    value = callPackage (./. + "/${name}") { };
  };
  names = builtins.attrNames dirContents;
in
builtins.listToAttrs (map genPackage names)

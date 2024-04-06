{ pkgs }:

let
  dirContents = builtins.readDir ./.;
  genPackage = name: {
    inherit name;
    value = pkgs.callPackage (./. + "/${name}") { };
  };
  names = builtins.attrNames dirContents;
in
builtins.listToAttrs (map genPackage names)

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    patchelf
    stdenv.cc
  ];
}


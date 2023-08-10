{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    gcc
    gnumake
    cargo
    rustc
    nodejs
    jdk17_headless
    maven
    kotlin
  ];
}


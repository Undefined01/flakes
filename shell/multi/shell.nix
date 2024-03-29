{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    gcc
    gnumake
    cmake
    rustc
    cargo
    nodejs
    python3
    jdk17_headless
    maven
    gradle
  ];
}


{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    cmake
    gdb
    rustc
    cargo
    nodejs
    python3Minimal
    jdk17_headless
    maven
    kotlin
  ];
}

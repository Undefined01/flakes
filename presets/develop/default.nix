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
    python3
    jdk17_headless
    maven
    kotlin
  ];
}

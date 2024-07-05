{ pkgs, isWsl, ... }:

{
  home.packages = with pkgs; [
    gcc
    gnumake

    jdk17_headless
    jdt-language-server

    nodejs
  ];
}

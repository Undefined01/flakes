{ inputs, pkgs, config, ... }:

{
  home.packages = with pkgs; [
    shell_gpt
  ];
}

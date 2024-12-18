{ pkgs, lib, ... }:

{
  fonts = {
    fontDir.enable = lib.mkIf (pkgs.stdenv.isLinux) true;
    packages = with pkgs; [
      # noto-fonts
      # noto-fonts-cjk-sans
      # noto-fonts-cjk-serif
      noto-fonts-emoji
      source-han-sans
      source-han-serif
      # cascadia-code
      # jetbrains-mono
      nerd-fonts.caskaydia-cove
      nerd-fonts.jetbrains-mono
    ];
  };
}

{ pkgs, lib, ... }:

{
  fonts = {
    packages = with pkgs; [
      # noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      # source-han-sans
      # source-han-serif
      # cascadia-code
      # jetbrains-mono
      # monaspace
      cascadia-code
      # nerd-fonts.symbols-only
      # nerd-fonts.caskaydia-cove
      # nerd-fonts.jetbrains-mono
    ];
  };
}

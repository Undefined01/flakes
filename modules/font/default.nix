{ pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      # noto-fonts
      # noto-fonts-cjk-sans
      # noto-fonts-cjk-serif
      noto-fonts-emoji
      source-han-sans
      source-han-serif
      cascadia-code
      (nerdfonts.override {
        fonts = [
          "CascadiaCode"
        ];
      })
    ];

    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "Noto Sans Mono CJK SC"
          "CaskaydiaCove Nerd Font"
          "Cascadia Code"
          "Source Code Pro"
          "DejaVu Sans Mono"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
          "Source Han Sans SC"
          "DejaVu Sans"
          "CaskaydiaCove Nerd Font"
        ];
        serif = [
          "Noto Serif CJK SC"
          "Source Han Serif SC"
          "DejaVu Serif"
          "CaskaydiaCove Nerd Font"
        ];
      };
    };
  };
}

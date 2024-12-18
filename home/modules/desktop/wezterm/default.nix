{ ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        font = wezterm.font_with_fallback({
          "JetBrainsMono Nerd Font",
          "Source Han Sans CN",

          -- Fallback to Wezterm's built-in font if the above fonts are not available
          "JetBrains Mono",
          "Noto Color Emoji",
          "Symbols Nerd Font Mono",
        }),
        font_dirs = { "/Library/Fonts/Nix Fonts" },
        front_end = "WebGpu",
      }
    '';
  };
}

{ lib, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.configFile.nvim =
    lib.mkIf (builtins.pathExists ./nvim-config)
      {
        source = ./nvim-config;
      };
}

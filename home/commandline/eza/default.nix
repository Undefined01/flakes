{ config, lib, ... }:

{
  options.custom.home.stacks.commandline.eza = {
    enable = lib.mkEnableOption "Enable eza.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.eza.enable {
    programs.eza = {
      enable = true;
      git = true;
      icons = "auto";
    };

    home.shellAliases = {
      ls = "eza --color=auto --time-style=iso";
      ll = "eza --color=auto --color-scale all --long --all --smart-group --time-style=iso";
      tree = "eza --color=auto --tree";
    };
  };
}

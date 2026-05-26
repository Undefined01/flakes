{ config, lib, ... }:

{
  options.custom.home.stacks.desktop.obsidian = {
    enable = lib.mkEnableOption "Enable Obsidian configuration.";
  };

  config = lib.mkIf config.custom.home.stacks.desktop.obsidian.enable {
    programs.obsidian = {
      enable = true;
    };
  };
}

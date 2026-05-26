{ config, lib, ... }:

{
  config = lib.mkIf (
    config.custom.home.stacks.commandline.git.enable
    && (
      let
        variant = config.custom.home.stacks.commandline.git.ui;
      in
      variant == "lazygit" || variant == "both"
    )
  ) {
    programs.lazygit = {
      enable = true;
    };
  };
}

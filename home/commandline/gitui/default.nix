{ config, lib, ... }:

{
  config =
    lib.mkIf
      (
        config.custom.home.stacks.commandline.git.enable
        && (
          let
            variant = config.custom.home.stacks.commandline.git.ui;
          in
          variant == "gitui" || variant == "both"
        )
      )
      {
        programs.gitui = {
          enable = true;
        };
      };
}

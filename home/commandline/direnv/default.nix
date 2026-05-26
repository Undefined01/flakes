{ config, lib, ... }:

{
  options.custom.home.stacks.commandline.direnv = {
    enable = lib.mkEnableOption "Enable direnv.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;

      config = {
        whitelist = {
          prefix = [ ];

          exact = [ ];
        };
      };
    };

    programs.git.ignores = [
      ".direnv/"
      ".envrc"
    ];
  };
}

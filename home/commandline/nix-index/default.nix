{ config, lib, ... }:

{
  options.custom.home.stacks.commandline.nixIndex = {
    enable = lib.mkEnableOption "Enable nix-index.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.nixIndex.enable {
    # A replacement for command-not-found in nix
    programs.nix-index = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
  };
}

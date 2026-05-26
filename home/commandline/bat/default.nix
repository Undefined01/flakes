{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.custom.home.stacks.commandline.bat = {
    enable = lib.mkEnableOption "Enable bat.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.bat.enable {
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
      ];
    };

    home.shellAliases = {
      cat = "bat";
      man = "batman";
    };
  };
}

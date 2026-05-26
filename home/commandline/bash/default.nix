{ config, lib, ... }:

{
  options.custom.home.stacks.commandline.shell.bash = {
    enable = lib.mkEnableOption "Enable bash configuration.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.shell.bash.enable {
    programs.bash = {
      enable = true;
      historySize = 10000;
      historyFileSize = 100000;
      historyControl = [
        "ignoredups"
        "ignorespace"
      ];
    };
  };
}

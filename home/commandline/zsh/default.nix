{ config, lib, ... }:

{
  options.custom.home.stacks.commandline.shell.zsh = {
    enable = lib.mkEnableOption "Enable zsh configuration.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.shell.zsh.enable {
    programs.zsh = {
      enable = true;
      autocd = true;
      history.size = 10000;
      history.save = 100000;
      history.share = false;
      history.ignoreDups = true;
      history.extended = true;
      initContent = ''
        setopt INC_APPEND_HISTORY_TIME
      '';
    };
  };
}

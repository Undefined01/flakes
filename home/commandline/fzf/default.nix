{ config, lib, ... }:

{
  options.custom.home.stacks.commandline.fzf = {
    enable = lib.mkEnableOption "Enable fzf.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.fzf.enable {
    programs.fzf = {
      enable = true;
      fileWidgetOptions = [
        "--layout=reverse"
        "--preview='(bat -f -n {} || cat {}) 2> /dev/null | head -500'"
      ];
      changeDirWidgetOptions = lib.mkIf config.programs.eza.enable [
        "--preview 'eza --color=always --tree --icons {} | head -200'"
      ];
      historyWidgetOptions = [ "--layout=reverse" ];
    };
  };
}

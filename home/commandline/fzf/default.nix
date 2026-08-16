{ config, lib, ... }:

{
  options.custom.home.stacks.commandline.fzf = {
    enable = lib.mkEnableOption "Enable fzf.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.fzf.enable {
    programs.fzf = {
      enable = true;
      fileWidget.options = [
        "--layout=reverse"
        "--preview='(bat -f -n {} || cat {}) 2> /dev/null | head -500'"
      ];
      changeDirWidget.options = lib.mkIf config.programs.eza.enable [
        "--preview 'eza --color=always --tree --icons {} | head -200'"
      ];

      # only enabled when atuin does not take-off ctrl+r
      historyWidget =
        if (!config.custom.home.stacks.commandline.atuin.enable) then
          {
            options = [ "--layout=reverse" ];
          }
        else
          {
            command = "";
          };
    };
  };
}

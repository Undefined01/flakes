{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.custom.home.stacks.commandline.fd = {
    enable = lib.mkEnableOption "Enable fd.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.fd.enable {
    home.packages = with pkgs; [
      fd
    ];

    programs.fzf = {
      defaultCommand = "fd --type f --hidden --follow --exclude .git";
      changeDirWidget.command = "fd --type d --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build}";
      fileWidget.command = "fd --type f --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build}";
    };
  };
}

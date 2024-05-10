{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fd
  ];

  programs.fzf = {
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    changeDirWidgetCommand = "fd --type d --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build}";
    fileWidgetCommand = "fd --type f --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build}";
  };
}

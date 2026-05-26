{ config, lib, ... }:

{
  options.custom.home.stacks.commandline.vim = {
    enable = lib.mkEnableOption "Enable vim.";
    defaultEditor = lib.mkEnableOption "Make vim the default editor.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.vim.enable {
    programs.vim = {
      enable = true;
      defaultEditor = config.custom.home.stacks.commandline.vim.defaultEditor;
    };
  };
}

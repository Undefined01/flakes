{ config, lib, ... }:

{
  options.custom.home.stacks.commandline.bottom = {
    enable = lib.mkEnableOption "Enable bottom.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.bottom.enable {
    programs.bottom.enable = true;
    home.shellAliases = {
      b = "btm --basic --process_memory_as_value --unnormalized_cpu --process_command";
    };
  };
}

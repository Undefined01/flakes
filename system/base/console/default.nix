{ config, lib, ... }:

{
  options.custom.system.stacks.base.console.enable = lib.mkEnableOption "Enable console settings.";

  config = lib.mkIf config.custom.system.stacks.base.console.enable {
    console = {
      keyMap = "us";
      # font = "Lat2-Terminus16";
      colors = [
        # OneDark
        "1e2127"
        "e06c75"
        "98c379"
        "d19a66"
        "61afef"
        "c678dd"
        "56b6c2"
        "abb2bf"
        "5c6370"
        "e06c75"
        "98c379"
        "d19a66"
        "61afef"
        "c678dd"
        "56b6c2"
        "ffffff"
      ];
    };
  };
}

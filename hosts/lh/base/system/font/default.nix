{ lib, isLinux, ... }:

{
  options.custom.system.stacks.base.font.enable = lib.mkEnableOption "Enable font configuration.";

  imports = [
    ./fonts.nix
  ]
  ++ lib.optionals isLinux [
    ./fontconfig.nix
  ];
}

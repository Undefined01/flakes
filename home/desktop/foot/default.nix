{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.home.stacks.desktop.foot = {
    enable = lib.mkEnableOption "Enable foot terminal.";
  };

  config = lib.mkIf config.custom.home.stacks.desktop.foot.enable {
    assertions = [
      {
        assertion = pkgs.stdenv.hostPlatform.isLinux;
        message = "foot terminal is only supported on Linux, not on ${pkgs.stdenv.hostPlatform.system}.";
      }
    ];

    programs.foot = {
      enable = true;
    };
  };
}

{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.custom.home.stacks.commandline.rclone = {
    enable = lib.mkEnableOption "Enable rclone.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.rclone.enable {
    home.packages = [
      pkgs.rclone
    ];
  };
}

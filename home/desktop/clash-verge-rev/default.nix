{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.custom.home.stacks.desktop.clashVergeRev = {
    enable = lib.mkEnableOption "Enable Clash Verge Rev configuration.";
  };

  config = lib.mkIf config.custom.home.stacks.desktop.clashVergeRev.enable {
    home.packages = [
      pkgs.clash-verge-rev
    ];

    # systemd.user.services.clash-verge = {
    #   Unit = {
    #     Description = "Clash Verge Service";
    #   };
    #   Service = {
    #     Restart = "on-failure";
    #     ExecStart = "${pkgs.clash-verge-rev}/bin/clash-verge-service";
    #   };
    # };
  };
}

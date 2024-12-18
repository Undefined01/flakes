{ pkgs, ... }:

{
  home.packages = [
    pkgs.clash-verge-rev
    (pkgs.makeAutostartItem {
      name = "clash-verge";
      package = pkgs.clash-verge-rev;
    })
  ];

  
  systemd.user.services.clash-verge = {
    Unit = {
      Description = "Clash Verge Service";
    };
    Service = {
      Restart = "on-failure";
      ExecStart = "${pkgs.clash-verge-rev}/bin/clash-verge-service";
    };
  };
}

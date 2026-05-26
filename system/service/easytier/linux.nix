{ config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf config.custom.system.stacks.service.easytier.enable {
    systemd.services.easytier = {
      enable = true;
      description = "EasyTier - A simple, safe, decentralized intranet penetration tool";
      after = [
        "network.target"
        "syslog.target"
      ];
      wants = [ "network.target" ];

      serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
        ExecStart = "${pkgs.easytier}/bin/easytier-core --config-file ${config.custom.system.stacks.service.easytier.configPath}";
      };

      wantedBy = [ "multi-user.target" ];
    };
  };
}
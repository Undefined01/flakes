{
  config,
  lib,
  ...
}:

{
  config = lib.mkIf config.custom.system.stacks.service.easytier.enable {
    sops.secrets.easytier-config = {
      sopsFile = ./config.toml.enc;
      format = "binary";
    };

    custom.system.stacks.service.easytier = {
      configPath = config.sops.secrets.easytier-config.path;
    };
  };
}

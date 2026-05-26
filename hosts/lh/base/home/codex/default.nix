{
  config,
  lib,
  ...
}:

{
  config = lib.mkIf config.custom.home.stacks.base.sops.enable {
    sops.secrets.ai_api_keys = {
      sopsFile = ./apikeys.enc;
      format = "binary";
    };
  };
}
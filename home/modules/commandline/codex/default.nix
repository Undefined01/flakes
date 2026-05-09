{ pkgs, inputs, ... }:

{
  home.mutableFile.".codex/config.toml" = {
    format = "toml";
    ownership = {
      default = "sealed";
      rules = [
        {
          path = [ "projects" ];
          mode = "local";
        }
        {
          path = [ "mcp_servers" ];
          mode = "local";
        }
      ];
    };
    layers = [
      {
        source = ./config.toml;
      }
    ];
  };

  sops.secrets.ai_api_keys = {
    sopsFile = ./apikeys.enc;
    format = "binary";
  };
}

{ lib, isLinux, ... }:

let
  inherit (lib) types;
in
{
  imports = lib.optionals isLinux [ ./linux.nix ];

  options = {
    custom.system.stacks.service.easytier = {
      enable = lib.mkEnableOption "Enable the EasyTier service stack.";
      configPath = lib.mkOption {
        type = types.either types.path types.str;
        example = "/etc/easytier/config.toml";
        description = "Path to the EasyTier configuration file.";
      };
    };
  };
}

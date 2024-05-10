{ inputs, lib, pkgs, config, user, ... }:

let
  cfg = config.secret;
  agecfg = config.age;

  secretUpdateType = with lib; types.submodule ({ config, ... }: {
    options = {
      name = mkOption {
        type = types.str;
        default = "";
        description = "The name of the systemd service";
      };
      runtimeInputs = mkOption {
        type = types.listOf types.package;
        default = [ ];
        description = "The runtime inputs to the update service";
      };
      script = mkOption {
        type = types.str;
        description = "The script to run on update";
      };
    };
  });

  secretType = with lib; types.submodule ({ config, name, ... }: {
    options = {
      name = mkOption {
        type = types.str;
        default = name;
        description = ''
          Name of the file used in ''${cfg.secretsDir}
        '';
      };
      file = mkOption {
        type = types.path;
        description = ''
          Age file the secret is loaded from.
        '';
      };
      path = mkOption {
        type = types.str;
        default = "${agecfg.secretsDir}/${config.name}";
        description = ''
          Path where the decrypted secret is installed.
        '';
      };
      mode = mkOption {
        type = types.str;
        default = "0400";
        description = ''
          Permissions mode of the decrypted secret in a format understood by chmod.
        '';
      };
      symlink = mkEnableOption "symlinking secrets to their destination" // { default = true; };
      updateService = mkOption {
        type = secretUpdateType;
        default = { };
      };
    };
  });

in
{
  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  options.secret = with lib; {
    enable = mkEnableOption "enable secrets management" // { default = false; };

    secrets = mkOption {
      type = types.attrsOf secretType;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {
    age = {
      identityPaths = [ "/home/${user}/.ssh/id_ed25519" ];
      secretsDir = "${config.home.homeDirectory}/.agenix/agenix";
      secretsMountPoint = "${config.home.homeDirectory}/.agenix/agenix.d";

      secrets = lib.mapAttrs
        (name: value: {
          inherit (value) name file path mode symlink;
        })
        cfg.secrets;
    };

    home.activation = {
      agenix = config.lib.dag.entryAnywhere config.systemd.user.services.agenix.Service.ExecStart;
    } // (lib.mapAttrs'
      (_: value:
        let
          name = value.name;
          runtimeInputs = value.updateService.runtimeInputs;
          script = value.updateService.script;
          updateScript = pkgs.lib.getExe (pkgs.writeShellApplication {
            name = "${name}-update-secrets";
            runtimeInputs = with pkgs; [ coreutils ] ++ runtimeInputs;
            text = script;
          });
        in
        {
          name = "${name}-update-secrets";
          value = config.lib.dag.entryAfter [ "agenix" ] updateScript;
        }
      )
      cfg.secrets
    );
  };
}

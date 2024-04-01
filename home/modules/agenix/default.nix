{ inputs, pkgs, config, user, ... }:

{
  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  age = {
    secretsDir = "${config.home.homeDirectory}/.agenix/agenix";
    secretsMountPoint = "${config.home.homeDirectory}/.agenix/agenix.d";
  };
  age.identityPaths = [ "/home/${user}/.ssh/id_ed25519" ];
  age.secrets.openai-api.file = ../../secrets/common.age;

  home.activation.agenix = config.lib.dag.entryAnywhere config.systemd.user.services.agenix.Service.ExecStart;
}

{
  config,
  lib,
  inputs,
  ...
}:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  options.custom.home.stacks.base.sops = {
    enable = lib.mkEnableOption "Enable sops-nix.";
  };

  config =  {
    sops = {
      age.sshKeyPaths = lib.mkDefault [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    };
  };
}
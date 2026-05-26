{
  lib,
  inputs,
  hostName,
  isLinux,
  isDarwin,
  ...
}:

{
  imports = [
    ./font
  ]
  ++ lib.optionals isLinux [
    inputs.sops-nix.nixosModules.sops
    ./easytier
  ]
  ++ lib.optionals isDarwin [
    inputs.sops-nix.darwinModules.sops
    ./brew
  ];

  custom.system.stacks.base.font.enable = lib.mkDefault true;
  custom.system.stacks.base.console.enable = lib.mkDefault isLinux;
  custom.system.profiles.minimal.enable = true;
}

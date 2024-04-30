{ inputs, outputs, user, config, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.useUserPackages = true;
  home-manager.users.${user} = import ../../home;

  home-manager.extraSpecialArgs = { inherit inputs outputs user; isWsl = if config ? wsl then config.wsl.enable else false; };
}

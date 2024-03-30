{ inputs, outputs, user, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${user} = import ../../home;

  home-manager.extraSpecialArgs = { inherit inputs outputs user; };
}

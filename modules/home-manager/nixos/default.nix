{ inputs, outputs, user, config, ... }:

let
  isWsl = if config ? wsl then config.wsl.enable else false;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs outputs user isWsl;
    };
  };
}

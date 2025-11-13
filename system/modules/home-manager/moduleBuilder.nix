homeConfiguration:

{ inputs, outputs, user, config, ... }:

let
  isWsl = if config ? wsl then config.wsl.enable else false;
in
{
  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs outputs user isWsl;
    };
    users.${user} = import homeConfiguration;
  };
}

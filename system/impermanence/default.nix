{ inputs, config, lib, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  config = lib.mkIf config.custom.system.stacks.impermanence.enable {
    environment = {
      persistence."/nix/persist" = {
        directories = [
          # "/etc/nixos" # bind mounted from /nix/persist/etc/nixos to /etc/nixos
          "/etc/NetworkManager/system-connections"
          "/var/log"
          "/var/lib"
        ];
        files = [
          "/etc/machine-id"
        ];
      };
    };
  };
}

{ ... }:

{
  imports = [
    ./secret.nix
  ];

  secret.enable = false;
}

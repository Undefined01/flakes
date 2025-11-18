{ lib, user, authorizedKeys, ... }:

{
  imports = [
    ./linux.nix
  ];

  users = {
    groups.${user} = { };
    users.${user} = {
      openssh.authorizedKeys.keys = authorizedKeys;
    };
  };
}

{ pkgs, lib, user, authorizedKeys, ... }:

{
  imports = [
    ./linux.nix
  ];

  users = {
    groups.${user} = { };
    users.${user} = {
      home = lib.mkDefault (
        if pkgs.stdenv.isDarwin
        then "/Users/${user}"
        else "/home/${user}"
      );
      openssh.authorizedKeys.keys = authorizedKeys;
    };
  };
}

{ pkgs, lib, isLinux, user, ... }:

lib.optionalAttrs isLinux {
  users = {
    mutableUsers = false;
    users.root.initialPassword = "${user}";
    users.${user} = {
      isNormalUser = true;
      group = "${user}";
      extraGroups = [ "wheel" "users" "${user}" ];
      initialPassword = "${user}";
    };
  };
}

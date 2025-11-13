{ lib, user, authorizedKeys, ... }:

{
  users = {
    mutableUsers = false;
    groups.${user} = { };
    users.root.initialPassword = "${user}";
    users.${user} = {
      isNormalUser = true;
      group = "${user}";
      extraGroups = [ "wheel" "users" "${user}" ];
      initialPassword = "${user}";
      openssh.authorizedKeys.keys = "${authorizedKeys}";
    };
  };
}

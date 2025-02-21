{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "invalid users" = [
          "root"
        ];
        "passwd program" = "/run/wrappers/bin/passwd %u";
        security = "user";
        "hosts allow" = "0.0.0.0/0";
      };
      public = {
        browseable = "yes";
        comment = "Public samba share.";
        "guest ok" = "yes";
        path = "/srv/public";
        "read only" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
      };
    };
  };
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}

{ ... }:

{
  services.openssh = {
    enable = true;
    extraConfig = ''
      ClientAliveInterval 30
      ClientAliveCountMax 60
      '';
  };
}


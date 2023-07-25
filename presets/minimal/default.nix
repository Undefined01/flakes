{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
}

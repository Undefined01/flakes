{ config, inputs, pkgs, user, ... }:

{
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";
  time.hardwareClockInLocalTime = true;
  console.keyMap = "us";
  console = {
    # font = "Lat2-Terminus16";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  # Select internationalisation properties.
  users.mutableUsers = false;
  users.groups.${user} = { };
  users.users.root.initialPassword = "${user}";
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "users" "${user}" ];
    initialPassword = "${user}";
    packages = with pkgs; [
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDcTQOKYRyLoviozP5Ba6k8N+1Sn7LZ1wECHiPa2FF1V amoscr@163.com"
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  nix = {
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      unstable.to = {
        "type" = "github";
        "owner" = "NixOS";
        "repo" = "nixpkgs";
        "ref" = "nixos-unstable";
      };
    };
  };

  programs.nix-ld.enable = true;
}

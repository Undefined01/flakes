{ config, inputs, pkgs, lib, user, ... }:

{
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  time.timeZone = "Asia/Shanghai";
  time.hardwareClockInLocalTime = true;
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable zram swap
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  # Disable password prompt for sudo in the wheel group
  security.sudo.wheelNeedsPassword = false;

  # Automatically link the required libraries for non-nixpkgs programs
  programs.nix-ld.enable = true;
}

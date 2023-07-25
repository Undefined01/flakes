{ config, pkgs, user, ... }:

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
  users.users.root.initialPassword = "${user}";
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "${user}" ];
    initialPassword = "${user}";
    packages = with pkgs; [
    ];
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
    auto-optimise-store = true;
  };
  nixpkgs.config.allowUnfree = true;
}
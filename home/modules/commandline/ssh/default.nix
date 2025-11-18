{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    package = pkgs.openssh;
    includes = [ "config.d/*" ];
    matchBlocks = {
      "*" = {
        serverAliveInterval = 15;
        serverAliveCountMax = 120;
      };
      github = {
        hostname = "github.com";
        user = "git";
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
      };
    };
  };

  home.packages = with pkgs; [
    sshfs
  ];
}

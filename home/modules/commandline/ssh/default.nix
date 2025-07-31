{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    package = pkgs.openssh;
    includes = [ "config.d/*" ];
    matchBlocks = {
      "*" = {
        serverAliveInterval = 15;
        serverAliveCountMax = 120;
      };
      h5 = {
        hostname = "107.172.5.176";
        user = "lh";
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
}

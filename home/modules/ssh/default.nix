{ user, ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      h5 = {
        hostname = "107.172.5.176";
        user = "${user}";
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

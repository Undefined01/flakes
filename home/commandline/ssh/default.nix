{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.custom.home.stacks.commandline.ssh = {
    enable = lib.mkEnableOption "Enable ssh configuration.";
  };

  config = lib.mkIf config.custom.home.stacks.commandline.ssh.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      package = pkgs.openssh;
      includes = [ "config.d/*" ];
      settings = {
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

    home.packages = lib.mkIf pkgs.stdenv.hostPlatform.isLinux [
      pkgs.sshfs
    ];
  };
}

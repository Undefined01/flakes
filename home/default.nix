{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  programs.git = {
    enable = true;
    userName = "Undefined01";
    userEmail = "amoscr@163.com";

    aliases = {
      graph = "log --decorate --oneline --graph";
    };

    difftastic = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core.autocrlf = "input";
      push.autoSetupRemote = true;
      merge.conflictStyle = "zdiff3";
      commit.verbose = true;
      log.date = "iso";
      column.ui = "auto";
      branch.sort = "committerdate";

user.signing.key = "77E1D17E9CA01924BC8A0FD7CD40B1410BA0D1DF";
      commit.gpgSign = true;
    };
  };

sops = {
    age.sshKeyPaths = [ "/home/user/id_" ];
    defaultSopsFile = ./secrets.yaml;
    secrets.test = {
      path = "%r/test.txt"; 
    };
  };

  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}

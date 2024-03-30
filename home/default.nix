{ inputs, outputs, lib, config, pkgs, user, ... }: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  programs.ssh = {
    enable = true;
    matchBlocks = {
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

      gpg.format = "ssh";
      user.signingkey = "/home/${user}/.ssh/id_ed25519.pub";
      commit.gpgSign = true;
    };
  };

  sops = {
    age.sshKeyPaths = [ "/home/${user}/id_ed25519" ];
    defaultSopsFile = ./secrets/common.yaml;
  };

  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}

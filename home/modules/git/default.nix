{ user, ... }:

{
  programs.git = {
    enable = true;
    userName = "Undefined01";
    userEmail = "amoscr@163.com";

    aliases = {
      graph = "log --decorate --oneline --graph";
      root = "rev-parse --show-toplevel";
    };

    difftastic = {
      enable = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
      core.autocrlf = "input";
      help.autocorrect = true;
      push.autoSetupRemote = true;
      merge.conflictStyle = "zdiff3";
      log.date = "iso";
      column.ui = "auto";
      branch.sort = "committerdate";

      commit.gpgSign = true;
      gpg.format = "ssh";
      user.signingkey = "/home/${user}/.ssh/id_ed25519.pub";
    };
  };
}

{ config, user, ... }:

{
  programs.git = {
    enable = true;
    userName = "Undefined01";
    userEmail = "amoscr@163.com";

    aliases = {
      graph = "log --all --decorate --oneline --graph";
      lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
      lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
      root = "rev-parse --show-toplevel";
    };

    difftastic = {
      enable = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
      core.autocrlf = "input";
      help.autocorrect = true;
      pull.rebase = false;
      push.autoSetupRemote = true;
      merge.conflictStyle = "zdiff3";
      log.date = "iso";
      column.ui = "auto";
      branch.sort = "committerdate";

      commit.gpgSign = true;
      gpg.format = "ssh";
      user.signingkey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
    };
  };

  programs.gpg.enable = true;
}

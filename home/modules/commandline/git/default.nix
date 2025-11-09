{ config, lib, ... }:

let
  inherit (lib) types;
  inherit (lib.attrsets) optionalAttrs;
  inherit (lib.options) mkOption;
  cfg = config.customize.git;
in
{
  options.customize.git = {
    signing = {
      enable = mkOption {
        type = types.bool;
        default = true;
        example = false;
        description = "Whether to enable commit signing.";
      };
    };
  };

  config = {
    programs.git = {
      enable = true;

      ignores = [ ".cache" "compile_commands.json" ];

      settings = lib.mkMerge [
        {
          user.name = "Undefined01";
          user.email = "amoscr@163.com";

          alias = {
            graph = "log --all --decorate --oneline --graph";
            lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
            lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
            root = "rev-parse --show-toplevel";
          };

          init.defaultBranch = "main";
          core.autocrlf = "input";
          pull.rebase = false;
          push.autoSetupRemote = true;
          merge.conflictStyle = "zdiff3";
          rebase.autostash = true;
          log.date = "iso";
          column.ui = "auto";
          branch.sort = "committerdate";
        }
        (optionalAttrs cfg.signing.enable {
          commit.gpgSign = true;
          gpg.format = "ssh";
          user.signingkey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        })
      ];
    };


    programs.difftastic = {
      enable = true;
      git.enable = true;
    };
    programs.gpg.enable = true;
  };
}

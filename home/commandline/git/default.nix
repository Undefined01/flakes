{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkDefault mkOption types;
  cfg = config.customize.git;

  difftCommand = "${lib.getExe pkgs.difftastic}";
in
{
  options.customize.git = {
    signing = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to sign git commits by default.";
      };
    };
    difftastic = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to enable difftastic integration for git.";
      };
    };
  };

  config = lib.mkIf config.custom.home.stacks.commandline.git.enable {
    programs.git = {
      enable = true;

      ignores = [
        ".cache"
        "compile_commands.json"
      ];

      signing = {
        signByDefault = mkDefault cfg.signing.enable;
        format = "ssh";
        key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      };

      settings = lib.mkMerge [
        {
          user.name = lib.mkDefault "Undefined01";
          user.email = lib.mkDefault "amoscr@163.com";

          alias = {
            graph = "log --all --decorate --oneline --graph";
            lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
            lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
            root = "rev-parse --show-toplevel";
          };

          init.defaultBranch = "main";
          core.autocrlf = "input";
          core.quotePath = false;
          pull.rebase = false;
          push.autoSetupRemote = true;
          merge.conflictStyle = "zdiff3";
          rebase.autostash = true;
          log.date = "iso";
          column.ui = "auto";
          branch.sort = "committerdate";
          rerere.enabled = true;
        }
        (lib.optionalAttrs cfg.difftastic.enable {
          alias.difft = "-c diff.external=${lib.escapeShellArg difftCommand} diff";
        })
      ];
    };

    programs.difftastic = lib.mkIf cfg.difftastic.enable {
      enable = true;
      git.enable = false;
    };
    programs.gpg.enable = true;
  };
}

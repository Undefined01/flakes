{ config, lib, pkgs, ... }:

let
  inherit (lib) mkDefault mkEnableOption mkIf mkOption types;
in
{
  imports = [
    ./nix-index
    ./git
    ./lazygit
    ./gitui
    ./ssh
    ./bash
    ./fish
    ./zsh
    ./starship
    ./eza
    ./bat
    ./ls-or-cat
    ./lsd
    ./bottom
    ./zoxide
    ./fd
    ./fzf
    ./tealdeer
    ./atuin
    ./yazi
    ./uv
    ./direnv
    ./neovim
    ./vim
    ./lsp
    ./rclone
    ./codex
    ./claudecode
    ./gpg-agent
  ];

  options.custom.home = {
    profiles.commandline = {
      enable = mkEnableOption "Enable the commandline home profile.";
      packages = mkOption {
        type = types.listOf types.package;
        default = with pkgs; [
          wget
          curl
          less
          man
          file
          zip
          unzip
          p7zip
          zstd
          vim

          gnupg
          openssl
          age

          dust
          ripgrep
          jq
          sd
          tokei
          difftastic

          zellij
        ];
        description = "Default packages for the commandline profile.";
      };
    };

    stacks.commandline = {
      editor = {
        variant = mkOption {
          type = types.enum [ "neovim" "vim" "none" ];
          default = "none";
          description = "Preferred editor variant.";
        };
        lsp.enable = mkEnableOption "Enable language server tooling.";
      };

      git = {
        enable = mkEnableOption "Enable git configuration.";
        ui = mkOption {
          type = types.enum [ "lazygit" "gitui" "both" "none" ];
          default = "both";
          description = "Preferred git UI.";
        };
        diff = mkOption {
          type = types.enum [ "difftastic" "diff" ];
          default = "difftastic";
          description = "Preferred git diff backend.";
        };
        fzf.enable = mkEnableOption "Enable git-related fzf integration.";
      };
    };
  };

  config =
    let
      cfg = config.custom.home;
    in
    mkIf cfg.profiles.commandline.enable {
      custom.home.stacks.base.enable = mkDefault true;

      custom.home.stacks.commandline.nixIndex.enable = mkDefault true;
      custom.home.stacks.commandline.ssh.enable = mkDefault true;

      custom.home.stacks.commandline.shell.bash.enable = mkDefault true;
      custom.home.stacks.commandline.shell.fish.enable = mkDefault true;
      custom.home.stacks.commandline.shell.zsh.enable = mkDefault true;
      custom.home.stacks.commandline.shell.starship.enable = mkDefault true;

      custom.home.stacks.commandline.git.enable = mkDefault true;
      custom.home.stacks.commandline.git.ui = mkDefault "both";
      custom.home.stacks.commandline.git.diff = mkDefault "difftastic";
      custom.home.stacks.commandline.git.fzf.enable = mkDefault true;

      custom.home.stacks.commandline.editor.variant = mkDefault "neovim";
      custom.home.stacks.commandline.editor.lsp.enable = mkDefault true;

      custom.home.stacks.commandline.neovim.enable = mkDefault (cfg.stacks.commandline.editor.variant == "neovim");
      custom.home.stacks.commandline.neovim.defaultEditor = mkDefault (cfg.stacks.commandline.editor.variant == "neovim");
      custom.home.stacks.commandline.vim.enable = mkDefault (cfg.stacks.commandline.editor.variant == "vim");
      custom.home.stacks.commandline.vim.defaultEditor = mkDefault (cfg.stacks.commandline.editor.variant == "vim");

      customize.git.difftastic.enable = mkDefault (cfg.stacks.commandline.git.diff == "difftastic");

      custom.home.stacks.commandline.bat.enable = mkDefault true;
      custom.home.stacks.commandline.eza.enable = mkDefault true;
      custom.home.stacks.commandline.lsOrCat.enable = mkDefault true;
      custom.home.stacks.commandline.lsd.enable = mkDefault false;
      custom.home.stacks.commandline.bottom.enable = mkDefault true;
      custom.home.stacks.commandline.zoxide.enable = mkDefault true;
      custom.home.stacks.commandline.fd.enable = mkDefault true;
      custom.home.stacks.commandline.fzf.enable = mkDefault true;
      custom.home.stacks.commandline.tealdeer.enable = mkDefault true;
      custom.home.stacks.commandline.atuin.enable = mkDefault true;
      custom.home.stacks.commandline.yazi.enable = mkDefault true;
      custom.home.stacks.commandline.uv.enable = mkDefault true;
      custom.home.stacks.commandline.direnv.enable = mkDefault true;
      custom.home.stacks.commandline.rclone.enable = mkDefault true;
      custom.home.stacks.commandline.codex.enable = mkDefault true;
      custom.home.stacks.commandline.claudecode.enable = mkDefault true;
      custom.home.stacks.commandline.gpgAgent.enable = mkDefault true;

      home.packages = cfg.profiles.commandline.packages;
    };
}
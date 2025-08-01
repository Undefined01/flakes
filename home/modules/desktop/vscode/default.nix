{ pkgs, lib, config, ... }@args:

let
  inherit (lib) types;
  inherit (lib.options) mkOption;
  cfg = config.customize.vscode;

  marketplace = (import ./extensions.nix) args;
  # Only extensions whose name is not in cfg.extensions.exclude are added
  filterExtensions = extList:
    builtins.filter
      (
        ext: lib.lists.all
          (
            excludedName: !(lib.strings.hasInfix excludedName ext.name)
          )
          cfg.extensions.exclude
      )
      extList;
in
{
  imports = [
    ./lang-cpp.nix
    ./lang-java.nix
    ./lang-javascript.nix
    ./lang-kotlin.nix
    ./lang-python.nix
    ./lang-rust.nix
    ./env-nix.nix
    ./clang-format.nix
  ];

  options.customize.vscode = {
    extensions = {
      presets = {
        all = mkOption {
          type = types.bool;
          default = true;
          example = false;
          description = "Whether to enable all the extension presets except specially specified.";
        };
      };
      include = mkOption {
        type = types.listOf types.package;
        default = [ ];
        description = ''
          Add some extensions
        '';
        example = lib.literalExpression ''
          [ wakatime.vscode-wakatime github.copilot github.copilot-chat ]
        '';
      };
      exclude = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = ''
          Exclude some extensions
        '';
        example = lib.literalExpression ''
          [ "wakatime.vscode-wakatime" "github.copilot" "github.copilot-chat" ]
        '';
      };
    };
  };

  config = {
    customize.vscode.extensions.include = with marketplace; [
      smcpeak.default-keys-windows
      ms-vscode.hexeditor
      alefragnani.bookmarks
      usernamehw.errorlens
      eamodio.gitlens
      wakatime.vscode-wakatime
      tamasfe.even-better-toml
      pflannery.vscode-versionlens
      grapecity.gc-excelviewer
      tomoki1207.pdf

      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      ms-vscode.remote-explorer
      ms-vscode.remote-server
      ms-kubernetes-tools.vscode-kubernetes-tools

      github.copilot
      github.copilot-chat
    ];

    programs.vscode = {
      enable = true;
      profiles.default = {
        extensions = filterExtensions cfg.extensions.include;

        userSettings =
          let
            addPrefix = prefix: attr:
              lib.attrsets.mapAttrs' (name: value: { name = "${prefix}.${name}"; value = value; }) attr;
          in
          (addPrefix "editor" {
            fontFamily = "'Cascadia Code NF', 'Cascadia Code', Consolas, 'Courier New', monospace";
            # customized for Cascadia Code NF, see https://github.com/microsoft/cascadia-code?tab=readme-ov-file#font-features
            fontLigatures = true;
            # customized for Monaspace Neon, see http://monaspace.githubnext.com/#code-ligatures
            # fontLigatures = "'calt', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'ss09', 'liga'";

            formatOnPaste = false;
            formatOnSave = false;
            formatOnType = false;

            mouseWheelZoom = true;
          }) // {
            "github.copilot.enable" = {
              "*" = true;
              "plaintext" = true;
              "markdown" = true;
            };

            "remote.SSH.configFile" = "${config.home.homeDirectory}/.vscode/remote-ssh-config";
            "settingsSync.ignoredSettings" = [
              "remote.SSH.configFile"
              "remote.SSH.remotePlatform"
            ];

            "update.mode" = "none";
            "extensions.autoUpdate" = false;

            "git.confirmSync" = false;
            "explorer.confirmDragAndDrop" = false;
            "explorer.confirmDelete" = false;
            "terminal.integrated.enableMultiLinePasteWarning" = "never";
          };
      };
    };
  };
}

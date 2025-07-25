{ pkgs, lib, config, ... }@args:

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

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with (import ./extensions.nix) args; [
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

      userSettings =
        let
          addPrefix = prefix: attr:
            lib.attrsets.mapAttrs' (name: value: { name = "${prefix}.${name}"; value = value; }) attr;
        in
        (addPrefix "editor" {
          fontFamily = "'CaskaydiaCove Nerd Font', 'Cascadia Code', Consolas, 'Courier New', monospace";
          fontLigatures = true;

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
}

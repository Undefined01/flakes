{ pkgs, ... }:

{
  imports = [
    ./lang-cpp.nix
    ./lang-java.nix
    ./lang-kotlin.nix
    ./lang-python.nix
    ./lang-rust.nix
    ./clang-format.nix
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-marketplace; [
      smcpeak.default-keys-windows
      ms-vscode.hexeditor
      alefragnani.bookmarks
      usernamehw.errorlens
      mhutchie.git-graph
      wakatime.vscode-wakatime

      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      ms-vscode.remote-explorer
      ms-vscode.remote-server

      github.copilot
      github.copilot-chat
    ];

    userSettings = {
      editor = {
        fontFamily = "'CaskaydiaCove Nerd Font', 'Cascadia Code', Consolas, 'Courier New', monospace";
        fontLigatures = true;

        formatOnPaste = false;
        formatOnSave = false;
        formatOnType = false;

        mouseWheelZoom = true;
      };

      "github.copilot.enable" = {
        "*" = true;
        "plaintext" = true;
        "markdown" = true;
      };

      "remote.SSH.configFile" = "/home/lh/.vscode/remote-ssh-config";

      "git.confirmSync" = false;
      "explorer.confirmDragAndDrop" = false;
      "explorer.confirmDelete"= false;
    };
  };
}

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
    extensions = with pkgs.vscode-extensions; [
      smcpeak.default-keys-windows-linux
      alefragnani.bookmarks
      usernamehw.errorlens
      mhutchie.git-graph
      github.copilot
      github.copilot-chat
      wakatime.vscode-wakatime
    ];

    user-settings = {
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
    };
  };
}

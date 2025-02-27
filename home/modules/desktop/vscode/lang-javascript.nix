{ pkgs, ... }:

{
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace; [
      dbaeumer.vscode-eslint
      esbenp.prettier-vscode
    ];

    userSettings = {
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescript]" = {
        "editor.defaultFormatter" = "vscode.typescript-language-features";
      };
    };
  };
}

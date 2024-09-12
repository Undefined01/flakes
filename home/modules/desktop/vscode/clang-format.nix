{ pkgs, ... }:

{
  programs.vscode = {
    extensions = with pkgs.pkgs.vscode-marketplace; [
      xaver.clang-format
    ];

    userSettings = {
      clang-format = {
        style = "{ BasedOnStyle: Google, IndentWidth: 4, IndentCaseLabels: false, AllowShortBlocksOnASingleLine: true, AllowShortIfStatementsOnASingleLine: true }";

        language = {
          "csharp.style" = "Microsoft";
        };
      };
    };
  };
}

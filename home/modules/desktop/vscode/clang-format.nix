{ pkgs, ... }:

{
  programs.vscode = {
    extensions = with pkgs.open-vsx-release; [
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

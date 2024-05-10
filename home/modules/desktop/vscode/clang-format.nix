{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      xaver.clang-format
    ];

    user-settings = {
      clang-format = {
        style = "{ BasedOnStyle: Google, IndentWidth: 4, IndentCaseLabels: false, AllowShortBlocksOnASingleLine: true, AllowShortIfStatementsOnASingleLine: true }";

        language = {
          "csharp.style" = "Microsoft";
        };
      };
    };
  };
}

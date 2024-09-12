{ pkgs, ... }:

{
  programs.vscode = {
    extensions = with pkgs.vscode-marketplace; [
      ms-python.python
      ms-python.black-formatter
      ms-python.mypy-type-checker
    ];

    userSettings = {
      "[python]" = {
        "editor.defaultFormatter" = "ms-python.black-formatter";
      };
    };
  };
}

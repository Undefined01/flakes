{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-python.python
      ms-python.black-formatter
    ];

    user-settings = {
      "[python]" = {
        "editor.defaultFormatter" = "ms-python.black-formatter";
      };
    };
  };
}

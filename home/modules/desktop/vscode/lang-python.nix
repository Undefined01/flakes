{ pkgs, ... }:

{
  programs.vscode = {
    extensions = with pkgs.vscode-marketplace; [
      ms-python.python
      ms-python.debugpy
      ms-python.black-formatter
      ms-python.vscode-pylance
      ms-python.mypy-type-checker
    ];

    userSettings = {
      "[python]" = {
        "editor.defaultFormatter" = "ms-python.black-formatter";
      };
      "remote.SSH.defaultExtensions" = [
        "ms-python.python"
        "ms-python.vscode-pylance"
        
        "ms-python.black-formatter"
        "ms-python.mypy-type-checker"
      ];
    };
  };
}

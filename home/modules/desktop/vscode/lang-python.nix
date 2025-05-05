{ pkgs, ... }:

{
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace; [
      ms-python.python
      ms-python.debugpy
      ms-toolsai.jupyter
      ms-python.vscode-pylance
      charliermarsh.ruff
    ];

    userSettings = {
      "[python]" = {
        "editor.defaultFormatter" = "charliermarsh.ruff";
      };
      "remote.SSH.defaultExtensions" = [
        "ms-python.python"
        "ms-python.vscode-pylance"

        "charliermarsh.ruff"
      ];
    };
  };
}

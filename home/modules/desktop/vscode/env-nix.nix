{ pkgs, ... }:

{
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace; [
      pinage404.nix-extension-pack
      arrterian.nix-env-selector
      jnoortheen.nix-ide
      mkhl.direnv
    ];
  };
}

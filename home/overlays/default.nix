{ inputs, ... }:

let
  override_package = pkgs: package: package.override (builtins.intersectAttrs package.override.__functionArgs pkgs);
in
{
  vscode-marketplace = inputs.nix-vscode-extensions.overlays.default;

  nur = inputs.nur.overlays.default;
}

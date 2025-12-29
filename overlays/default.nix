{ inputs, ... }:

let
  override_package =
    pkgs: package: package.override (builtins.intersectAttrs package.override.__functionArgs pkgs);
in
{
  vscode-marketplace = inputs.nix-vscode-extensions.overlays.default;
  nur = inputs.nur.overlays.default;

  myPackages =
    final: prev:
    inputs.nixpkgs.lib.packagesFromDirectoryRecursive {
      callPackage = inputs.nixpkgs.lib.callPackageWith final;
      directory = ../pkgs;
    };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

}

{ inputs, ... }:

let
  override_package = pkgs: package: package.override (builtins.intersectAttrs package.override.__functionArgs pkgs);
in
{
  vscode-marketplace = inputs.nix-vscode-extensions.overlays.default;
  nur = inputs.nur.overlays.default;

  myPackages = final: prev: import ../pkgs { inherit final prev; pkgs = final; };

  modifications = final: prev: {
    gitui =
      if prev.stdenv.isDarwin && prev.stdenv.hostPlatform.system == "aarch64-darwin"
      then final.gitui-bin
      else prev.gitui;
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

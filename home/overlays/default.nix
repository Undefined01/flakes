{ inputs, ... }:

let
  override_package = pkgs: package: package.override (builtins.intersectAttrs package.override.__functionArgs pkgs);
in
{
  shell_gpt = final: prev: {
    shell_gpt = final.unstable.shell-gpt;
  };

  java = final: prev: {
    jdt-language-server = (override_package final final.unstable.jdt-language-server).override {
      jdk = prev.jdk17_headless;
    };
  };

  neovim = final: prev: {
    neovim-unwrapped = final.unstable.neovim-unwrapped;
  };

  vscode-marketplace = inputs.nix-vscode-extensions.overlays.default;
}

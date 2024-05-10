{ inputs, ... }:

let
  override_package = pkgs: package: package.override (builtins.intersectAttrs package.override.__functionArgs pkgs);
in
{
  shell_gpt = final: prev: {
    shell_gpt = final.unstable.shell-gpt;
  };

  neovim = final: prev: {
    neovim-unwrapped = final.unstable.neovim-unwrapped;
  };
}

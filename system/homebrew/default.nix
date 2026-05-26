{
  pkgs,
  inputs,
  config,
  lib,
  hostMeta,
  ...
}:
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  config = lib.mkIf config.custom.system.stacks.homebrew.enable {
    homebrew = {
      # TODO: this is a workaround for https://github.com/nix-darwin/nix-darwin/pull/1341
      # In the long run, this setting will be deprecated and removed after all the
      # functionality it is relevant for has been adjusted to allow
      # specifying the relevant user separately, moved under the
      # `users.users.*` namespace, or migrated to Home Manager.
      user = hostMeta.username;
      enable = true;
      taps = builtins.attrNames config.nix-homebrew.taps;
    };

    nix-homebrew = {
      user = hostMeta.username;
      enable = true;
      taps = {
        "homebrew/homebrew-core" = inputs.homebrew-core;
        "homebrew/homebrew-cask" = inputs.homebrew-cask;
        "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
        # "nikitabobko/homebrew-aerospace" = inputs.homebrew-aerospace;   # Aerospace is installed by nix
        # "recronin/homebrew-sogou-input" = inputs.homebrew-sogou-input;  # no longer available in homebrew
      };
      mutableTaps = false;
      autoMigrate = true;
    };
  };
}

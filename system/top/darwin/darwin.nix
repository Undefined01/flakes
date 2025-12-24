{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = map lib.custom.fromFlakeRoot [
    "system/presets/minimal"
    "system/modules/homebrew"
    "system/modules/base/font/fonts.nix"
    "system/presets/users/lh.nix"
  ];

  hostSpec.users.lh.homeConfiguration = lib.custom.fromFlakeRoot "home/top/darwin/darwin.nix";

  # nix integration for zsh and fish
  programs.zsh.enable = true;
  programs.fish.enable = true;

  nixpkgs.hostPlatform = "aarch64-darwin";

  system = {
    stateVersion = 5;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  };
}

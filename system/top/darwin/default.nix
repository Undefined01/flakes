{ inputs, pkgs, user, ... }:

{
  imports = [
    ../../presets/minimal
    ../../modules/homebrew
    ../../modules/base/font/fonts.nix
  ];

  # nix integration for zsh and fish
  programs.zsh.enable = true;
  programs.fish.enable = true;

  system = {
    stateVersion = 5;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  };
}

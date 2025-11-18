{ inputs, pkgs, user, ... }:

{
  imports = [
    ../../modules/homebrew

    ../../presets/minimal
    ../../modules/base/font/fonts.nix
  ];

  time.timeZone = "Asia/Shanghai";

  # nix integration for zsh and fish
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Allow sudo authentication with Touch ID
  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    stateVersion = 5;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  };
}

{ inputs, pkgs, user, ... }:

{
  imports = [
    ../../modules/nix
    ../../modules/nix/nix-darwin.nix
    ../../modules/homebrew

    ./system-preferences.nix

    ../../presets/commandline/common.nix
  ];

  # nix integration for zsh and fish
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Allow sudo authentication with Touch ID
  security.pam.enableSudoTouchIdAuth = true;

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  system = {
    stateVersion = 5;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  };
}

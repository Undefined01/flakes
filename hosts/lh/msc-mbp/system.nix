{ inputs, ... }:

let
  meta = import ./meta.nix;
in
{
  custom.system.profiles.minimal.enable = true;

  custom.system.stacks.base.font.enable = true;
  custom.system.stacks.homebrew.enable = true;

  custom.system.users.${meta.username} = {
    name = meta.username;
    authorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDcTQOKYRyLoviozP5Ba6k8N+1Sn7LZ1wECHiPa2FF1V amoscr@163.com"
    ];
    homeConfiguration = ./home.nix;
  };

  custom.system.host.primaryUser = meta.username;

  # nix integration for zsh and fish
  programs.zsh.enable = true;
  programs.fish.enable = true;

  nixpkgs.hostPlatform = meta.platform;

  system = {
    stateVersion = 5;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  };
}

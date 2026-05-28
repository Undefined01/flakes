{ inputs, hostMeta, ... }:

{
  imports = [
    ../base/system
  ];

  custom.system.stacks.homebrew.enable = true;

  custom.system.users.${hostMeta.username} = {
    name = hostMeta.username;
    authorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDcTQOKYRyLoviozP5Ba6k8N+1Sn7LZ1wECHiPa2FF1V amoscr@163.com"
    ];
    homeConfiguration = ./home.nix;
  };

  # nix integration for zsh and fish
  programs.zsh.enable = true;
  programs.fish.enable = true;

  system = {
    stateVersion = 5;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  };
}

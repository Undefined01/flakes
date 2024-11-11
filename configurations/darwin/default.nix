{ inputs, pkgs, user, ... }:

{
  imports = [
    ../../modules/nix
    ../../modules/nix/nix-darwin.nix
    ../../modules/homebrew

    ./system-preferences.nix

    ../../presets/commandline/common.nix
  ];

  time.timeZone = "Asia/Shanghai";

  # nix integration for zsh and fish
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Allow sudo authentication with Touch ID
  security.pam.enableSudoTouchIdAuth = true;

  # Select internationalisation properties.
  users = {
    groups.${user} = { };
    users.${user} = {
      home = "/Users/${user}";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDcTQOKYRyLoviozP5Ba6k8N+1Sn7LZ1wECHiPa2FF1V amoscr@163.com"
      ];
    };
  };

  system = {
    stateVersion = 5;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  };
}

{ inputs, pkgs, user, ... }:

{
  imports = [
    ../../presets/commandline/common.nix
  ];

  # nix integration for zsh and fish
  programs.zsh.enable = true;
  programs.fish.enable = true;

  homebrew = {
    enable = true;
    casks = [
        "mos"
    ];
  };

  nix-homebrew = {
    inherit user;
    enable = true;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
    };
    mutableTaps = false;
    autoMigrate = true;
  };

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  system = {
    stateVersion = 5;

    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };

      dock = {
        autohide = false;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 48;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };
  };

  nix = {
    settings = {
      trusted-users = [ "@admin" "${user}" ];
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" "https://nix-community.cachix.org" "https://cache.nixos.org/" ];
    };
    gc = {
      automatic = true;
      interval = { Weekday = 1; Hour = 0; Minute = 0; };
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
  };

  nixpkgs.config.allowUnfree = true;
}

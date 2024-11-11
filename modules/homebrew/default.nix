{ pkgs, inputs, user, ... }:
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  homebrew = {
    enable = true;
    casks = [
      "mos"
      # "macfuse"
      "clash-verge-rev"
      "wezterm"
      "visual-studio-code"
      "qq"
      "wechat"
      "thunderbird"
      "zotero"
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
}

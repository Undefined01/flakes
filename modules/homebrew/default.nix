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
      "rwts-pdfwriter"
      "clash-verge-rev"
      # "wezterm"   # installed by nix
      # "visual-studio-code"  # installed by nix
      "qq"
      "wechat"
      "thunderbird"
      "zotero"
      "obs"
      "vlc"
      "zerotier-one"
      "tencent-meeting"
    ];
  };

  nix-homebrew = {
    inherit user;
    enable = true;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
      "nikitabobko/homebrew-aerospace" = inputs.homebrew-aerospace;
    };
    mutableTaps = false;
    autoMigrate = true;
  };
}

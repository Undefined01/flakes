{ pkgs, inputs, user, ... }:
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  homebrew = {
    # TODO: this is a workaround for https://github.com/nix-darwin/nix-darwin/pull/1341
    # In the long run, this setting will be deprecated and removed after all the
    # functionality it is relevant for has been adjusted to allow
    # specifying the relevant user separately, moved under the
    # `users.users.*` namespace, or migrated to Home Manager.
    user = user;
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
      "cleanclip"
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

{ pkgs, ... }:

{
  programs.thunderbird = {
    enable = true;
    profiles.lh = {
      isDefault = true;
    };
  };
}

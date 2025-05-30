{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.lh = {
      isDefault = true;
      search.default = "bing";
      search.force = true;
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        immersive-translate
        adblocker-ultimate
        tampermonkey
        bitwarden
        user-agent-string-switcher
      ];
    };
  };
}

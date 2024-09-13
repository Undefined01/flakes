{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.lh = {
      isDefault = true;
      search.default = "Bing";
      search.force = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        immersive-translate
        adblocker-ultimate
        tampermonkey
        lastpass-password-manager
        user-agent-string-switcher
      ];
    };
  };
}

{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf config.custom.system.stacks.desktop.input.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-rime
          qt6Packages.fcitx5-chinese-addons
          fcitx5-table-extra
          # config.nur.repos.ruixi-rebirth.fcitx5-pinyin-moegirl
          # config.nur.repos.ruixi-rebirth.fcitx5-pinyin-zhwiki
        ];
      };
    };
  };
}

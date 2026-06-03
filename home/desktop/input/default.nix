{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.custom.home.stacks.desktop.input = {
    enable = lib.mkEnableOption "Enable desktop input configuration.";
  };

  config = lib.mkIf config.custom.home.stacks.desktop.input.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          (fcitx5-rime.override {
            rimeDataPkgs = [
              rime-wanxiang
            ];
          })
        ];
      };
    };
  };
}

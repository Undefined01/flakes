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
    targets.darwin.defaults = {
      "com.apple.inputsources" = {
        AppleEnabledThirdPartyInputSources = [
          {
            "Bundle ID" = "im.rime.inputmethod.Squirrel";
            "Input Mode" = "im.rime.inputmethod.Squirrel.Hans";
            InputSourceKind = "Input Mode";
          }
          {
            "Bundle ID" = "im.rime.inputmethod.Squirrel";
            InputSourceKind = "Keyboard Input Method";
          }
        ];
      };
    };
  };
}

{
  targets.darwin = {
    defaults = {
      # Workaround for AeroSpace window manager,
      # see https://nikitabobko.github.io/AeroSpace/guide#a-note-on-mission-control
      "com.apple.dock" = {
        expose-group-apps = true;
      };
      # Workaround for AeroSpace window manager,
      # see https://nikitabobko.github.io/AeroSpace/guide#a-note-on-displays-have-separate-spaces
      "com.apple.spaces" = {
        spans-displays = true;
      };
    };
  };
}

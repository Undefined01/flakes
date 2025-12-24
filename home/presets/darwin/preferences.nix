{
  config,
  pkgs,
  lib,
  ...
}:

{
  targets.darwin = {
    defaults = {
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };

      NSGlobalDomain = {
        # Enable two finger swipe to navigate backward or forward
        AppleEnableMouseSwipeNavigateWithScrolls = true;
        AppleEnableSwipeNavigateWithScrolls = true;
        # Auto switch between light and dark mode
        AppleInterfaceStyleSwitchesAutomatically = true;

        AppleICUForce24HourTime = true;
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = true;
        AppleTemperatureUnit = "Celsius";

        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;

        # Disable the character modification menu when holding a key down, just repeat the key
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;

        "com.apple.mouse.tapBehavior" = 1;
        # Do not make a feedback beep when adjusting volume
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.sound.beep.volume" = 0.0;

        # Natrual scrolling direction, suitable for touchpad
        # For mouse, use mos to reverse the scrolling direction
        "com.apple.swipescrolldirection" = true;
        "com.apple.trackpad.forceClick" = true;
        "com.apple.trackpad.scaling" = 0.875;

        # Use fn keys as standard function keys
        "com.apple.keyboard.fnState" = 1;

      };

      "com.apple.dock" =
        let
          # Convert the item to dock tile
          # Copied from https://github.com/nix-darwin/nix-darwin/blob/e2676937faf868111dcea6a4a9cf4b6549907c9d/modules/system/defaults/dock.nix#L172-L196
          guessType =
            item:
            if builtins.isString item then
              if lib.strings.hasSuffix ".app" item then
                { app = item; }
              else if lib.strings.hasSuffix "/" item then
                { folder = item; }
              else
                { file = item; }
            else
              item;
          toTile =
            item:
            if item ? app then
              {
                tile-type = "file-tile";
                tile-data = { };
                tile-data.file-data = {
                  _CFURLString = item.app;
                  _CFURLStringType = 0;
                };
              }
            else if item ? spacer then
              {
                tile-data = { };
                tile-type = if item.spacer.small then "small-spacer-tile" else "spacer-tile";
              }
            else if item ? folder then
              {
                tile-data.file-data = {
                  _CFURLString = "file://" + item.folder;
                  _CFURLStringType = 15;
                };
                tile-type = "directory-tile";
              }
            else if item ? file then
              {
                tile-data.file-data = {
                  _CFURLString = "file://" + item.file;
                  _CFURLStringType = 15;
                };
                tile-type = "file-tile";
              }
            else
              item;
          toTiles = items: map toTile (map guessType items);
        in
        {
          orientation = "bottom";
          autohide = true;
          autohide-delay = 0;
          minimize-to-application = false;
          magnification = false;

          show-recents = false;

          persistent-apps = toTiles [
            # "/System/Applications/Utilities/Terminal.app"
            "${pkgs.wezterm}/Applications/WezTerm.app"
            "${pkgs.vscode}/Applications/Visual Studio Code.app"
            "/Applications/Firefox.app"
            "/System/Applications/System Settings.app"

            { spacer.small = true; }
          ];
          persistent-others = toTiles [
            "${config.home.homeDirectory}/Documents/"
            "${config.home.homeDirectory}/Downloads/"
          ];
          tilesize = 48;

          # Disable hot corners action
          # Full list of actions can be found at https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.wvous-bl-corner
          wvous-tl-corner = 1;
          wvous-tr-corner = 1;
          wvous-bl-corner = 1;
          wvous-br-corner = 1;
        };

      "com.apple.finder" = {
        AppleShowAllFiles = true;
        _FXShowPosixPathInTitle = true;
      };

      # 充电提示音
      "com.apple.PowerChime" = {
        ChimeOnAllHardware = true;
      };

      "com.apple.AppleMultitouchTrackpad" = {
        # Enable tap-to-click
        Clicking = true;
        # Enable tap-to-drag
        Dragging = true;
        # Enable two finger tap for right click
        TrackpadRightClick = 1;
        TrackpadHandResting = 1;
        TrackpadHorizScroll = 1;
        TrackpadMomentumScroll = 1;
        # Enable three finger drag
        TrackpadThreeFingerDrag = true;
        TrackpadThreeFingerHorizSwipeGesture = 2;
        TrackpadThreeFingerTapGesture = 0;
        TrackpadThreeFingerVertSwipeGesture = 2;
        TrackpadTwoFingerDoubleTapGesture = 1;
        TrackpadTwoFingerFromRightEdgeSwipeGesture = 3;
        # Enable four finger swipe for mission control
        TrackpadFourFingerHorizSwipeGesture = 2;
        # Enable four finger swipe for app expose
        TrackpadFourFingerVertSwipeGesture = 2;
      };

      "com.apple.Siri" = {
        StatusMenuVisible = 0;
        VoiceTriggerUserEnabled = 0;
      };
      "com.apple.WindowManager" = {
        AppWindowGroupingBehavior = 1;
        AutoHide = 0;
        EnableStandardClickToShowDesktop = 0;
      };
      "com.apple.menuextra.clock" = {
        FlashDateSeparators = false;
        IsAnalog = false;
        ShowAMPM = false;
        ShowDate = 0;
        ShowDayOfWeek = true;
        ShowSeconds = false;
      };
    };
  };

  # Set Home and End keys to move to the beginning and end of lines like Windows
  # https://discussions.apple.com/thread/251108215?sortBy=rank
  home.file."Library/KeyBindings/DefaultKeyBinding.dict" = {
    enable = true;
    text = ''
      {
        "\UF729" = "moveToBeginningOfLine:"; /* Home */
        "\UF72B" = "moveToEndOfLine:"; /* End */
        "$\UF729" = "moveToBeginningOfLineAndModifySelection:"; /* Shift + Home */
        "$\UF72B" = "moveToEndOfLineAndModifySelection:"; /* Shift + End */
        "^\UF729" = "moveToBeginningOfDocument:"; /* Ctrl + Home */
        "^\UF72B" = "moveToEndOfDocument:"; /* Ctrl + End */
        "$^\UF729" = "moveToBeginningOfDocumentAndModifySelection:"; /* Shift + Ctrl + Home */
        "$^\UF72B" = "moveToEndOfDocumentAndModifySelection:"; /* Shift + Ctrl + End */
      }
    '';
  };
}

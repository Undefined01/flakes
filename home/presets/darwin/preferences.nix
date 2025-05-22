{ config, pkgs, lib, user, ... }:

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
      };

      "com.apple.dock" = let
        # Convert the item to dock tile
        # Copied from https://github.com/nix-darwin/nix-darwin/blob/e2676937faf868111dcea6a4a9cf4b6549907c9d/modules/system/defaults/dock.nix#L172-L196
        endsWith = str: suffix:
          if (builtins.isString str) && (builtins.stringLength str) >= (builtins.stringLength suffix) then
            (lib.substring ((builtins.stringLength str) - (builtins.stringLength suffix)) (builtins.stringLength suffix) str) == suffix
          else
            false;
        guessType = item:
          if builtins.isString item then
            if endsWith item ".app" then { app = item; }
            else if endsWith item "/" then { folder = item; }
            else { file = item; }
          else item;
        toTile = item: if item ? app then {
          tile-type = "file-tile";
          tile-data = { };
        tile-data.file-data = {
          _CFURLString = item.app;
          _CFURLStringType = 0;
        };
        } else if item ? spacer then {
          tile-data = { };
          tile-type = if item.spacer.small then "small-spacer-tile" else "spacer-tile";
        } else if item ? folder then {
          tile-data.file-data = {
            _CFURLString = "file://" + item.folder;
            _CFURLStringType = 15;
          };
          tile-type = "directory-tile";
        } else if item ? file then {
          tile-data.file-data = {
            _CFURLString = "file://" + item.file;
            _CFURLStringType = 15;
          };
          tile-type = "file-tile";
        } else item;
        toTiles = items: lib.debug.traceValSeq (map toTile (map guessType items));
      in {
        orientation = "bottom";
        autohide = true;
        autohide-delay = 0;
        
        show-recents = true;

        persistent-apps = toTiles [
          "/System/Applications/Launchpad.app"
          # "/System/Applications/Utilities/Terminal.app"
          "${pkgs.wezterm}/Applications/WezTerm.app"
          "${pkgs.vscode}/Applications/Visual Studio Code.app"
          "/Applications/Firefox.app"
          "/System/Applications/App Store.app"
          "/System/Applications/System Settings.app"
        ];
        persistent-others = toTiles [
          "/Users/${user}/Documents/"
          "/Users/${user}/Downloads/"
        ];
        tilesize = 48;

        # Mission control
        # wvous-tl-corner = 2;
        # Application Windows
        # wvous-tr-corner = 3;
        # Launchpad
        # wvous-bl-corner = 11;
        # Desktop
        # wvous-br-corner = 4;
      };

      "com.apple.finder" = {
        AppleShowAllFiles = true;
        _FXShowPosixPathInTitle = true;
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
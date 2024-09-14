{ ... }:

{
  system = {
    defaults = {
      NSGlobalDomain = {
        # Enable two finger swipe to navigate backward or forward
        AppleEnableMouseSwipeNavigateWithScrolls = true;
        AppleEnableSwipeNavigateWithScrolls = true;
        # Auto switch between light and dark mode
        AppleInterfaceStyleSwitchesAutomatically = true;

        AppleICUForce24HourTime = true;
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = 1;
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

      dock = {
        autohide = true;
        show-recents = true;
        orientation = "bottom";
        persistent-apps = [
          "/System/Applications/Launchpad.app"
          "/System/Applications/Utilities/Terminal.app"
          "/Applications/Vscode.app"
          "/Applications/Firefox.app"
          "/System/Applications/App Store.app"
          "/System/Applications/System Settings.app"
        ];
        persistent-others = [
          "~/Documents"
          "~/Downloads"
        ];
        tilesize = 48;

        # Mission control
        wvous-tl-corner = 2;
        # Application Windows
        wvous-tr-corner = 3;
        # Launchpad
        wvous-bl-corner = 11;
        # Desktop
        wvous-br-corner = 4;
      };

      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
      };

      trackpad = {
        # Enable tap-to-click
        Clicking = true;
        # Enable tag-to-drag
        Dragging = true;
        TrackpadThreeFingerDrag = true;
      };
    };
  };
}

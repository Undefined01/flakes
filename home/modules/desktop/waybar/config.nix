{
  mainBar = {
    # Position and dimensions commented out as they seem to be defaults or unused in the example
    # layer = "top";
    # position = "bottom";
    # width = 1280;
    # height = 24; # For auto height, you might want to remove or adjust this
    # spacing = 4;

    modules-left = [ "sway/workspaces" "sway/mode" "sway/scratchpad" "custom/media" ];
    modules-center = [ "sway/window" ];
    modules-right = [ "mpd" "idle_inhibitor" "temperature" "cpu" "memory" "network" "pulseaudio" "backlight" "keyboard-state" "battery" "battery#bat2" "tray" "clock" ];

    "keyboard-state" = {
      numlock = true;
      capslock = true;
      format = "{name} {icon}";
      "format-icons" = {
        locked = "";
        unlocked = "";
      };
    };

    "sway/mode" = {
      format = "<span style=\"italic\">{}</span>";
    };

    "sway/scratchpad" = {
      format = "{icon} {count}";
      "show-empty" = false;
      "format-icons" = [ "" "" ];
      tooltip = true;
      "tooltip-format" = "{app}: {title}";
    };

    mpd = {
      format = "  {title} - {artist} {stateIcon} [{elapsedTime:%M:%S}/{totalTime:%M:%S}] {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}[{songPosition}/{queueLength}] [{volume}%]";
      "format-disconnected" = " Disconnected";
      "format-stopped" = " {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped";
      "unknown-tag" = "N/A";
      interval = 2;
      "consume-icons" = {
        on = " ";
      };
      "random-icons" = {
        on = " ";
      };
      "repeat-icons" = {
        on = " ";
      };
      "single-icons" = {
        on = "1 ";
      };
      "state-icons" = {
        paused = "";
        playing = "";
      };
      "tooltip-format" = "MPD (connected)";
      "tooltip-format-disconnected" = "MPD (disconnected)";
      "on-click" = "mpc toggle";
      "on-click-right" = "foot -a ncmpcpp ncmpcpp";
      "on-scroll-up" = "mpc volume +2";
      "on-scroll-down" = "mpc volume -2";
    };

    idle_inhibitor = {
      format = "{icon}";
      "format-icons" = {
        activated = "";
        deactivated = "";
      };
    };

    tray = {
      spacing = 10;
    };

    clock = {
      "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format = "{:L%Y-%m-%d<small>[%a]</small> <tt><small>%p</small></tt>%I:%M}";
    };

    cpu = {
      format = " {usage}%";
    };

    memory = {
      format = " {}%";
    };

    temperature = {
      "thermal-zone" = 2;
      "hwmon-path" = "/sys/class/hwmon/hwmon1/temp1_input";
      "critical-threshold" = 80;
      "format-critical" = "{icon} {temperatureC}°C";
      format = "{icon} {temperatureC}°C";
      "format-icons" = [ "" "" "" ];
    };

    backlight = {
      format = "{icon} {percent}%";
      "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
    };

    battery = {
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{icon} {capacity}%";
      "format-charging" = " {capacity}%";
      "format-plugged" = " {capacity}%";
      "format-alt" = "{icon} {time}";
      "format-icons" = [ "" "" "" "" "" ];
    };

    "battery#bat2" = {
      bat = "BAT2";
    };

    network = {
      "format-wifi" = "{essid} ({signalStrength}%) ";
      "format-ethernet" = " {ifname}";
      "tooltip-format" = " {ifname} via {gwaddr}";
      "format-linked" = " {ifname} (No IP)";
      "format-disconnected" = "Disconnected ⚠ {ifname}";
      "format-alt" = " {ifname}: {ipaddr}/{cidr}";
    };

    pulseaudio = {
      "scroll-step" = 5; # %, can be a float
      format = "{icon} {volume}% {format_source}";
      "format-bluetooth" = " {icon} {volume}% {format_source}";
      "format-bluetooth-muted" = "  {icon} {format_source}";
      "format-muted" = "  {format_source}";
      "format-source" = " {volume}%";
      "format-source-muted" = "";
      "format-icons" = {
        "default" = [ "" "" "" ];
      };
      "on-click" = "pavucontrol";
      "on-click-right" = "foot -a pw-top pw-top";
    };

    "custom/media" = {
      format = "{icon} {}";
      "return-type" = "json";
      "max-length" = 40;
      "format-icons" = {
        spotify = "";
        "default" = "🎜";
      };
      escape = true;
      exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
      # "exec" = "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null"; # Filter player based on name
    };
  };
}

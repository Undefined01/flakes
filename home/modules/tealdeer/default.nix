{ ... }:

{
  programs.tealdeer = {
    enable = true;
    settings.updates = {
      auto_update = false;
      auto_update_interval_hours = 7 * 24;
    };
  };
}

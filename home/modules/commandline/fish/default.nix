{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
  };

  # [https://wiki.nixos.org/wiki/Fish](https://wiki.nixos.org/w/index.php?title=Fish&oldid=1222)
  # Using fish as login shell may cause issues because fish is not POSIX compliant.
  # So we keep bash as the system shell but have it exec fish when run interactively. 
  programs.bash = {
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
}

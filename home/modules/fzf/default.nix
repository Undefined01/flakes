{ ... }:

{
  programs.fzf = {
    enable = true;
    defaultOptions = [ "--layout=reverse" "--preview='(bat -f -n {} || cat {}) 2> /dev/null | head -500'" ];
  };
}

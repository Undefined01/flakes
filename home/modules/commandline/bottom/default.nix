{ ... }:

{
  programs.bottom.enable = true;
  home.shellAliases = {
    b = "btm --basic --mem_as_value --unnormalized_cpu --process_command";
  };
}

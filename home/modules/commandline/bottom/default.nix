{ ... }:

{
  programs.bottom.enable = true;
  home.shellAliases = {
    b = "btm --basic --process_memory_as_value --unnormalized_cpu --process_command";
  };
}

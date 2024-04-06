{ ... }:

{
  imports = [ ./nerd-font-symbols.nix ];

  programs.starship = {
    enable = true;
    settings = {
      cmd_duration = {
        disabled = false;
        min_time = 500;
        show_milliseconds = true;
        show_notifications = true;
        min_time_to_notify = 60 * 1000;
      };
      time = {
        disabled = false;
      };

      # exit code
      status = {
        disabled = false;
      };

      format = builtins.replaceStrings [ "\\\n" ] [ "" ] ''
        $username\
        $hostname\
        $localip\
        $shlvl\
        $singularity\
        $kubernetes\
        $directory\
        $vcsh\
        $fossil_branch\
        $fossil_metrics\
        $git_branch\
        $git_commit\
        $git_state\
        $git_metrics\
        $git_status\
        $hg_branch\
        $pijul_channel\
        $docker_context\
        $package\
        $c\
        $cmake\
        $cobol\
        $daml\
        $dart\
        $deno\
        $dotnet\
        $elixir\
        $elm\
        $erlang\
        $fennel\
        $golang\
        $guix_shell\
        $haskell\
        $haxe\
        $helm\
        $java\
        $julia\
        $kotlin\
        $gradle\
        $lua\
        $nim\
        $nodejs\
        $ocaml\
        $opa\
        $perl\
        $php\
        $pulumi\
        $purescript\
        $python\
        $quarto\
        $raku\
        $rlang\
        $red\
        $ruby\
        $rust\
        $scala\
        $solidity\
        $swift\
        $terraform\
        $typst\
        $vlang\
        $vagrant\
        $zig\
        $buf\
        $nix_shell\
        $conda\
        $meson\
        $spack\
        $memory_usage\
        $aws\
        $gcloud\
        $openstack\
        $azure\
        $direnv\
        $env_var\
        $crystal\
        $custom\
        $sudo\
        $cmd_duration\
        $jobs\
        $battery\
        $time\
        $status\
        $line_break\
        $os\
        $container\
        $shell\
        $character
      '';
    };
  };

  # Transient prompt in fish
  # function starship_transient_prompt_func
  #   starship module directory
  #   starship module status
  #   starship module cmd_duration
  #   starship module time
  #   starship module line_break
  #   starship module character
  # end
  # enable_transience
}

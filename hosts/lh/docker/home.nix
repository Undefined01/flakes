{ ... }:

{
  imports = [
    ../base/home
  ];

  home.sessionVariables = {
    GIT_SSH = "/usr/bin/ssh";
  };
}

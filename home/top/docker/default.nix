{
  imports = [
    ../../presets/commandline
  ];

  customize.git.signing.enable = false;
  home.sessionVariables = {
    # The ssh in base image is patched with extra features, which is enabled by the config in system.
    # Hence, we have to use the system's ssh instead of the one provided by nix.
    GIT_SSH = "/usr/bin/ssh";
  };
}

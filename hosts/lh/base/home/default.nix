{
  lib,
  hostMeta,
  isLinux,
  isDarwin,
  ...
}:

{
  imports = [
    ./sops-nix
    ./codex
  ]
  ++ lib.optionals isDarwin [
    ./darwin-preferences
  ];

  config = {
    home.username = lib.mkDefault hostMeta.username;
    home.homeDirectory = lib.mkDefault (
      if isLinux then
        "/home/${hostMeta.username}"
      else if isDarwin then
        "/Users/${hostMeta.username}"
      else
        throw "Unsupported platform"
    );

    custom.home.stacks.base.enable = true;
    custom.home.profiles.commandline.enable = lib.mkDefault true;
    custom.home.stacks.base.sops.enable = lib.mkDefault true;

    customize.git.signing.enable = lib.mkDefault true;
  };
}

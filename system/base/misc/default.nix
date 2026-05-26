{
  config,
  lib,
  isLinux,
  isDarwin,
  ...
}:

{
  options.custom.system.stacks.base.misc.enable = lib.mkEnableOption "Enable misc system defaults.";

  imports = [
  ]
  ++ lib.optionals isLinux [
    ./linux.nix
  ]
  ++ lib.optionals isDarwin [
    ./darwin.nix
  ];

  config = lib.mkIf config.custom.system.stacks.base.misc.enable {
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    time.timeZone = "Asia/Shanghai";
  };
}

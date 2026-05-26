{
  lib,
  isLinux,
  isDarwin,
  ...
}:

{
  imports = [
    ./base
    ./commandline
    ./desktop
  ]
  ++ lib.optionals isLinux [
    ./hardware
    ./impermanence
  ]
  ++ lib.optionals isDarwin [ ./homebrew ];
}

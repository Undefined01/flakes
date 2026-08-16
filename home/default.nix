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
  ]
  ++ lib.optionals isLinux [
    ./desktop
  ]
  ++ lib.optionals isDarwin [
    ./darwin
  ];
}

{ lib, isLinux, isDarwin, ... }:

{
  imports = [
    ./base
    ./commandline
    ./desktop
  ] ++ lib.optionals isLinux [ ./linux ]
    ++ lib.optionals isDarwin [ ./darwin ];
}
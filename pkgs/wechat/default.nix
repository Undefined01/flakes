{ pkgs
, lib
}:

let
  version = "1.0.0.238";
  libs = pkgs.lib.makeLibraryPath (with pkgs; [
    stdenv.cc.cc.lib
    glib
    bzip2
    zlib
    dbus
    libxkbcommon
    nss
    nss_latest
    nspr
    fontconfig
    freetype
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXfixes
    xorg.libXrandr
    xorg.libXrender
    xorg.libxcb
    xorg.xcbutilrenderutil
    xorg.xcbutilkeysyms
    xorg.xcbutilimage
    xorg.xcbutilwm
    qt5.qtbase
    qt5.qtwayland
  ]);
in
pkgs.stdenv.mkDerivation {
  name = "wechat-beta-${version}";
  src = pkgs.fetchurl {
    name = "wechat-beta.deb";
    url = "https://github.com/lovechoudoufu/wechat_for_linux/releases/download/wechat-beta_${version}_amd64/wechat-beta_${version}_amd64_login.deb";
    sha256 = "sha256-kSz9MGQe83amgLBca9y3DLPxVMuettDTpX0jvv4juZw=";
  };
  buildInputs = with pkgs; [
    dpkg
  ];

  nativeBuildInputs = [
    # pkgs.autoPatchelfHook
    pkgs.libsForQt5.wrapQtAppsHook
  ];

  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
  '';

  postFixup = ''
    for file in $(find $out -type f \( -perm /0111 -o -name \*.so\* \) ); do
      echo "patching $file"
      ${pkgs.patchelf}/bin/patchelf \
        --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        "$file" || true
      ${pkgs.patchelf}/bin/patchelf \
        --add-rpath "${libs}" \
        "$file" || true
    done
  '';

  meta = with lib; {
    description = "Wechat";
    homepage = https://weixin.qq.com/;
    # license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };

}

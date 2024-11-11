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
  ]);
in
pkgs.stdenv.mkDerivation {
  name = "wechat-beta-${version}";
  src = pkgs.fetchurl {
    name = "wechat-beta.rpm";
    url = "https://mirrors.opencloudos.tech/opencloudos/9.2/extras/x86_64/os/Packages/wechat-beta_1.0.0.242_amd64.rpm";
    sha256 = "sha256-/5fXEfPHHL6G75Ph0EpoGvXD6V4BiPS0EQZM7SgZ1xk=";
  };

  dontUnpack = true;

  buildInputs = with pkgs; [
    dpkg
    libarchive
  ];

  nativeBuildInputs = [
    # pkgs.autoPatchelfHook
  ];

  installPhase = ''
    mkdir -p $out
    bsdtar -xf $src -C $out
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

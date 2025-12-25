{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  dpkg,
  alsa-lib,
  at-spi2-atk,
  cairo,
  cups,
  dbus,
  expat,
  glib,
  gtk3,
  libGL,
  libgbm,
  libxkbcommon,
  musl,
  nspr,
  nss,
  pango,
  udev,
  xorg,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "sparkle";
  version = "1.6.16";

  src =
    let
      selectSystem =
        attrs:
        attrs.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
      asset = selectSystem {
        x86_64-linux = "sparkle-linux-${finalAttrs.version}-amd64.deb";
        aarch64-linux = "sparkle-linux-${finalAttrs.version}-arm64.deb";
        x86_64-darwin = "sparkle-macos-${finalAttrs.version}-x64.pkg";
        aarch64-darwin = "sparkle-macos-${finalAttrs.version}-arm64.pkg";
      };
    in
    fetchurl {
      url = "https://github.com/xishang0128/sparkle/releases/download/${finalAttrs.version}/${asset}";
      hash = selectSystem {
        x86_64-linux = "sha256-rd4HwFgxVQtskIi6ktOzipESAWhhKxQ2YrZhs8omE5U=";
        aarch64-linux = "sha256-ScWlWd5D/8XaJEPbicwID2aolqyNionQcjpSAj36Zoo=";
        x86_64-darwin = "sha256-HayQMI3+IrXsj2DvYfqbKWbjVuk4Sqd4ileJ4deTZpg=";
        aarch64-darwin = "sha256-nQOO4tgC18Ty2ACEGMymA1o3h9+IynAtjCZoUjWI4jE=";
      };
    };

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
    xar
  ];

  buildInputs = [
    alsa-lib
    at-spi2-atk
    cairo
    cups
    dbus
    expat
    glib
    gtk3
    libGL
    libgbm
    libxkbcommon
    musl
    nspr
    nss
    pango
    udev
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
    (lib.getLib stdenv.cc.cc)
  ];

  installPhase = ''
    runHook preInstall
  '' + lib.optionalString stdenv.hostPlatform.isLinux ''
    mkdir -p $out/bin
    cp -r opt $out/opt
    substituteInPlace usr/share/applications/sparkle.desktop \
      --replace-fail "/opt/sparkle/sparkle" "sparkle"
    cp -r usr/share $out/share
    ln -s $out/opt/sparkle/sparkle $out/bin/sparkle
    '' + lib.optionalString stdenv.hostPlatform.isDarwin ''
    xar -xf $src
    cp -r Applications $out/Applications
    '' + ''
    runHook postInstall
  '';

  preFixup = ''
    patchelf --add-needed libGL.so.1 $out/opt/sparkle/sparkle
  '';

  passthru.updateScript = ./update.sh;

  meta = {
    description = "Another Mihomo GUI";
    homepage = "https://github.com/xishang0128/sparkle";
    license = lib.licenses.gpl3Plus;
    mainProgram = "sparkle";
    maintainers = [ ];
    platforms = [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
})
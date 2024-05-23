{ lib, stdenvNoCC, fetchurl, fetchzip, makeBinaryWrapper, jre }:

stdenvNoCC.mkDerivation rec {
  version = "4.8.5";
  pname = "spotbugs";

  src = fetchzip {
    url = "https://mirror.ghproxy.com/https://github.com/spotbugs/spotbugs/releases/download/${version}/spotbugs-${version}.zip";
    sha256 = "sha256-g6rpzabY1HAjZolJ0o8xaS+wNudY/XHi9T0NVeWQOg0=";
  };
  unpack = false;

  nativeBuildInputs = [ makeBinaryWrapper ];
  buildInputs = [ jre ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib
    cp -r $src/lib/* $out/lib
    for LIB in "$out"/lib/*.jar; do
      if [[ -z "''${LIBS// }" ]]; then
        LIBS=$LIB
      else
        LIBS=$LIB:$LIBS
      fi
    done

    makeWrapper ${jre}/bin/java $out/bin/spotbugs \
      --add-flags "-cp \"$LIBS\" edu.umd.cs.findbugs.LaunchAppropriateUI -pluginList \"$FINDBUGS_PLUGIN\""
    ls $out
    ls $out/lib

    runHook postInstall
  '';

  meta = with lib; {
    description = "SpotBugs is a program which uses static analysis to look for bugs in Java code";
    mainProgram = "spotbugs";
    longDescription = ''
      checkstyle is a development tool to help programmers write Java code that
      adheres to a coding standard. By default it supports the Sun Code
      Conventions, but is highly configurable.
    '';
    homepage = "https://checkstyle.org/";
    changelog = "https://checkstyle.org/releasenotes.html#Release_${version}";
    sourceProvenance = with sourceTypes; [ binaryBytecode ];
    license = licenses.lgpl21;
    platforms = jre.meta.platforms;
  };
}

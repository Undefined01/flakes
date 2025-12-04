{ stdenv
, stdenvNoCC
, fetchurl
, gitui
, gnutar
, gzip
, lib
}:

let
  pname = "gitui";
  version = "0.27.0";
  tarballUrl = "https://github.com/gitui-org/gitui/releases/download/v${version}/gitui-mac.tar.gz";
  sha256 = "0236dnc2ybj32qi7bq6683mgblq21vvjb78byvlavmidfhk94zqn";
in
if stdenv.isDarwin && stdenv.hostPlatform.system == "aarch64-darwin"
then
  stdenvNoCC.mkDerivation
  {
    inherit pname version;
    src = fetchurl { url = tarballUrl; inherit sha256; };

    nativeBuildInputs = [ gnutar gzip ];
    unpackPhase = "true";
    installPhase = ''
      mkdir -p $out/bin
      ${gnutar}/bin/tar -xzf $src
      install -m755 gitui $out/bin/gitui
    '';

    meta = with lib; {
      description = "Blazing fast terminal-ui for git written in Rust (binary package for Apple Silicon)";
      homepage = "https://github.com/gitui-org/gitui";
      license = licenses.mit;
      platforms = [ "aarch64-darwin" ];
      maintainers = [ ];
    };
  }
else gitui


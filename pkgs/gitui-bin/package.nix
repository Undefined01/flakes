{
  fetchurl,
  stdenvNoCC,
  lib,
  ...
}:

let
  pname = "gitui";
  version = "0.29.0";
  tarballUrl = "https://github.com/gitui-org/gitui/releases/download/v${version}/gitui-mac.tar.gz";
  sha256 = "0236dnc2ybj32qi7bq6683mgblq21vvjb78byvlavmidfhk94zqn";
in
stdenvNoCC.mkDerivation {
  inherit pname version;
  src = fetchurl {
    url = tarballUrl;
    inherit sha256;
  };

  unpackPhase = "true";
  installPhase = ''
    mkdir -p $out/bin
    tar -xzf $src
    install -m755 gitui $out/bin/gitui
  '';

  meta = {
    description = "Blazing fast terminal-ui for git written in Rust (binary package for Apple Silicon)";
    homepage = "https://github.com/gitui-org/gitui";
    license = lib.licenses.mit;
    platforms = [ "aarch64-darwin" ];
    maintainers = [ ];
  };
}

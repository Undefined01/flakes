{ inputs, ... }:

let
  override_package = pkgs: package: package.override (builtins.intersectAttrs package.override.__functionArgs pkgs);
in
{
  vscode-marketplace = inputs.nix-vscode-extensions.overlays.default;

  nur = inputs.nur.overlays.default;

  gitui = (final: prev:
    let
      pname = "gitui";
      version = "0.27.0";
      tarballUrl = "https://github.com/gitui-org/gitui/releases/download/v${version}/gitui-mac.tar.gz";
      sha256 = "0236dnc2ybj32qi7bq6683mgblq21vvjb78byvlavmidfhk94zqn";
    in
    {
      gitui =
        if prev.stdenv.isDarwin && prev.stdenv.hostPlatform.system == "aarch64-darwin"
        then
          prev.stdenvNoCC.mkDerivation
            {
              inherit pname version;
              src = prev.fetchurl { url = tarballUrl; inherit sha256; };

              nativeBuildInputs = [ prev.gnutar prev.gzip ];
              unpackPhase = "true";
              installPhase = ''
                mkdir -p $out/bin
                ${prev.gnutar}/bin/tar -xzf $src
                install -m755 gitui $out/bin/gitui
              '';

              meta = with prev.lib; {
                description = "Blazing fast terminal-ui for git written in Rust (binary package for Apple Silicon)";
                homepage = "https://github.com/gitui-org/gitui";
                license = licenses.mit;
                platforms = [ "aarch64-darwin" ];
                maintainers = [ ];
              };
            }
        else prev.gitui;
    }
  );
}

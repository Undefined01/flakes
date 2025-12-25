#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash nix curl coreutils common-updater-scripts nix-update jq

currentVersion=$(nix-instantiate --eval -A packages.x86_64-linux.sparkle.version | tr -d '"')
latestVersion=$(curl ${GITHUB_TOKEN:+-u ":$GITHUB_TOKEN"} -sL https://api.github.com/repos/xishang0128/sparkle/releases/latest | jq --raw-output .tag_name)

echo "latest  version: $latestVersion"
echo "current version: $currentVersion"

nix-update sparkle --flake --version $latestVersion
for arch in x86_64-linux aarch64-linux x86_64-darwin aarch64-darwin; do
    hash=$(nix --extra-experimental-features nix-command hash convert --to sri --hash-algo sha256 $(nix-prefetch-url $(nix-instantiate --eval -E "with import ./.; packages.${arch}.sparkle.src.url" --system $arch | tr -d '"')))
    update-source-version sparkle $latestVersion $hash --system=$arch --ignore-same-version
done

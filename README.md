# Installation

1. Install Nix package manager
   
   1. For NixOS or WSL-NixOS

      They are included in the system. No need to install seperately.

   2. For other Linux distribution and macOS

     ```bash
     sh <(curl -L https://nixos.org/nix/install)
     ```

     Or using the installer from DeterminateSystems:

     ```bash
     curl -fsSL https://install.determinate.systems/nix | sh -s -- install --prefer-upstream-nix
     ```

     If you change your mind, you can uninstall nix by

     ```
     /nix/nix-installer uninstall
     ```

     Or uninstall it manually following [the instructions in nix manual](https://nix.dev/manual/nix/2.33/installation/uninstall.html).

3. Clone this repo

   If git is not installed, you can have git available in a nix shell with `nix --extra-experimental-features "nix-command flakes" shell nixpkgs#git`.

   ``` bash
   git clone --recursive https://github.com/undefined01/flakes
   cd flakes
   git submodule update --init --recursive
   ```

4. Switch to this configuration

   To temporarily enable flakes and third-party substituters, ensure you are a trusted user of nix (root in clean setup) and export the following environment variable in your shell:

   ```bash
   export NIX_CONFIG="
   experimental-features = nix-command flakes
   substituters = https://mirrors.ustc.edu.cn/nix-channels/store https://cache.nixos.org/ https://nix-community.cachix.org https://undefined01.cachix.org
   trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= undefined01.cachix.org-1:9ZQ59dYp2cR8S5p87DaKqjtIyjZ1qMHmM2JtzpQl1dU=
   "
   ```

   1. For NixOS or WSL-NixOS, the nixosConfiguration is applied.

      ```bash
      sudo -E nixos-rebuild switch --flake ".?submodules=1#wsl"
      ```
    
      You can select the profile to switch to by changing the name after the hashtag, e.g. `.?submodules=1#work`.

      You may need to generate a hardware configuration with:
      ```
      sudo -E nix shell nixpkgs#nixos-install-tools --command nixos-generate-config --show-hardware-config > hardware-configuration.nix
      sudo -E nix run nixpkgs#nixos-facter > facter.json
      ```

   2. For other Linux distribution, the homeConfiguration is applied.

      ```bash
      sudo -E nix run home-manager -- switch --flake ".?submodules=1#lh"
      ```

      nix cannot change the system-wide configurations for non-NixOS distributions. You have to edit the nix configuration manually. It is usually placed at `/etc/nix/nix.conf`.

      ```
      experimental-features = nix-command flakes
      trusted-users = root @admin @sudo @wheel
      substituters = https://mirrors.ustc.edu.cn/nix-channels/store https://cache.nixos.org/ https://nix-community.cachix.org https://undefined01.cachix.org
      trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= undefined01.cachix.org-1:9ZQ59dYp2cR8S5p87DaKqjtIyjZ1qMHmM2JtzpQl1dU=
      ```

      If your nix command are missing after incomplete rebuild, try `. ~/.nix-profile/etc/profile.d/nix.sh` to recover the access to nix command.

   3. For macOS, the darwinConfiguration is applied.

      ```bash
      sudo -E nix run nix-darwin -- switch --flake ".?submodules=1#darwin"
      ```

      After installation, you can rebuild the configuration by darwin-rebuild

      ```bash
      sudo darwin-rebuild switch --flake ".?submodules=1#darwin"
      ```

      You may also need to run `killall Dock` to restart the Dock to apply the modification of system preference.

# Known Issues

- Immersive Translate extension for Firefox is currently disabled due to security issues.

- Gitui build failed due to the deprecation of [sha1-asm](https://github.com/RustCrypto/asm-hashes) [![](https://img.shields.io/github/issues/detail/state/NixOS/nixpkgs/450861)](https://github.com/NixOS/nixpkgs/issues/450861)

    Temporary workaround: [use pre-built binaries](./pkgs/gitui-bin/default.nix) from the GitHub releases page.

# Useful Commands

- [NixOS Search](https://search.nixos.org/): Search NixOS packages and options

- [Home Manager Search](https://home-manager-options.extranix.com/): Search Home Manager options

- [Noogle](https://noogle.dev/): Search Nix API

- [Nixpkgs Tracker](https://nixpkgs-tracker.ocfox.me/): Track whether a PR is merged into nixpkgs

- [EmergentMind's Nix Config](https://github.com/EmergentMind/nix-config)

- Debug a package:

   1. Enter develop shell: `nix-shell default.nix -A package` or `nix develop .#package`
   2. Fetch source code in a temporary directory: `cd $(mktemp -d) && runPhase unpackPhase`
   3. Run each phase defined in [stdenv](https://github.com/NixOS/nixpkgs/blob/0b72e585e4f71181bb00a0dcf41cf534c8fe4f24/pkgs/stdenv/generic/setup.sh#L1778-L1791)

      ```bash
      runPhase configurePhase
      runPhase buildPhase
      runPhase checkPhase
      runPhase installPhase
      runPhase fixupPhase
      ```

```
# set up the proxy
export {http_proxy,https_proxy,HTTP_PROXY,HTTPS_PROXY,all_proxy,ALL_PROXY}="http://172.25.64.1:7891"

# update submodules
git submodule update --init --recursive

# Formatting code
nix fmt .

# System-wide garbage collection, make sure your latest system build can boot successfully before removing old generations.
nix-collect-garbage --delete-old

# Setting up secrets for nix
nix run nixpkgs#sops home/secrets/common.yaml
bash -c 'cd home/secrets/; nix run .#agenix -- -e common.age

# visualize the Nix store and its size
nix run github:utdemir/nix-tree
nix shell nixpkgs#{bash,graphviz,nix-du} -c bash -c 'nix-du | dot -Tpng > store.png'

# Build an ISO image
nix build .#nixosConfigurations.iso.config.system.build.isoImage

# Set up a temporary proxy for the Nix daemon. Note that this configuration will be lost after a reboot.
# It is recommended to enable TUN mode in your proxy software to capture all traffic.
sudo bash -c '
PROXY="http://localhost:7891"
mkdir -p /run/systemd/system/nix-daemon.service.d
cat << EOF >/run/systemd/system/nix-daemon.service.d/override.conf  
[Service]
Environment="http_proxy=$PROXY"
Environment="https_proxy=$PROXY"
Environment="all_proxy=$PROXY"
EOF
systemctl daemon-reload
systemctl restart nix-daemon
'
```

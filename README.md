
You can switch to this configuration in a fresh NixOS by:

``` bash
cd /tmp
nix --extra-experimental-features "nix-command flakes" shell nixpkgs#git
git clone --recursive https://github.com/undefined01/flakes
cd flakes
git submodule update --init --recursive
sudo -E nixos-rebuild switch --option substituters "https://mirrors.ustc.edu.cn/nix-channels/store https://nix-community.cachix.org https://cache.nixos.org/" --flake ".?submodules=1#wsl"
sudo -E nixos-install --no-root-password 
```

You can install nix and switch to this configuration in darwin by:
``` bash
cd /tmp
sh <(curl -L https://nixos.org/nix/install)
nix --extra-experimental-features "nix-command flakes" shell nixpkgs#git
git clone --recursive https://github.com/undefined01/flakes
cd flakes
sudo -E nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake ".?submodules=1#darwin"
# After installation, you can rebuild the configuration by darwin-rebuild
git submodule update --init --recursive
sudo darwin-rebuild switch --flake ".?submodules=1#darwin"
```

You may need to set up the proxy before installation by `export {http_proxy,https_proxy,HTTP_PROXY,HTTPS_PROXY,all_proxy,ALL_PROXY}="http://172.25.64.1:7891"`.

Some useful commands:

```
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

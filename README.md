
You can switch to this configuration in a fresh NixOS.

``` bash
cd /tmp
nix --extra-experimental-features "nix-command flakes" shell nixpkgs#git
git clone https://github.com/undefined01/flakes
sudo -E nixos-rebuild switch --option substituters "https://mirrors.ustc.edu.cn/nix-channels/store https://nix-community.cachix.org https://cache.nixos.org/" --flake ".?submodules=1#wsl"
sudo -E nixos-install --no-root-password 
```

You may need to set up the proxy before installation by `export {http_proxy,https_proxy,HTTP_PROXY,HTTPS_PROXY,all_proxy,ALL_PROXY}="http://172.25.64.1:7891"`.

Some useful commands:

```
nix fmt

# system wide 
sudo nix-collect-garbage --delete-old
# homemanager
nix-collect-garbage --delete-old

nix run nixpkgs#sops home/secrets/common.yaml
bash -c 'cd home/secrets/; nix run .#agenix -- -e common.age)

nix shell nixpkgs#{bash,graphviz,nix-du} -c bash -c 'nix-du | dot -Tpng > store.png'

nix build .#nixosConfigurations.iso.config.system.build.isoImage
```

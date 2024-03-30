
You can switch to this configuration in a fresh NixOS.

``` bash
cd /tmp
nix --extra-experimental-features "nix-command flakes" shell nixpkgs#git
git clone https://github.com/undefined01/flakes
sudo -E nixos-rebuild switch --option substituters https://mirrors.ustc.edu.cn/nix-channels/store --flake .#wsl
```

You may need to set up the proxy before installation by `export {http_proxy,https_proxy,HTTP_PROXY,HTTPS_PROXY,all_proxy,ALL_PROXY}="http://172.25.64.1:7891"`.

Some useful commands:

```
nix fmt

nix run nixpkgs#sops secrets/common.yaml
```

curl -fsSL https://install.determinate.systems/nix | sh -s -- install --prefer-upstream-nix --no-confirm
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
nix registry add nixpkgs https://mirrors.ustc.edu.cn/nix-channels/nixos-26.05/nixexprs.tar.xz

cat /etc/nix/nix.custom.conf <<EOF
extra-experimental-features = nix-command flakes pipe-operators
trusted-users = root @admin @sudo @wheel
substituters = https://mirrors.ustc.edu.cn/nix-channels/store https://cache.nixos.org/ https://nix-community.cachix.org https://undefined01.cachix.org
trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= undefined01.cachix.org-1:9ZQ59dYp2cR8S5p87DaKqjtIyjZ1qMHmM2JtzpQl1dU=
EOF

sudo bash -c '/nix/var/nix/profiles/default/bin/nix-daemon > /var/log/nix-daemon.log 2>&1 & echo $! > /var/log/nix-daemon.pid'
nix run nixpkgs#home-manager -- switch --flake ".#lh-docker" -b backup


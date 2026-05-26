# Hosts

The flake now discovers host definitions from `hosts/lh/*`. Each immediate subdirectory is one host, and the folder name becomes the flake output name.

## Layout

```text
hosts/
  lh/
    <host>/
      meta.nix
      home.nix
      system.nix    # only for system-managed hosts
```

## `meta.nix`

Every host keeps a small metadata file next to its config files. The flake uses this file to decide how to build the host.

Typical shape:

```nix
{
  kind = "nixos"; # or "darwin" or "home-only"
  platform = "x86_64-linux";
  username = "lh";
  description = "Primary workstation";
}
```

Fields:

- `kind`: selects the builder.
  - `nixos` builds a NixOS system configuration.
  - `darwin` builds a nix-darwin system configuration.
  - `home-only` builds only a Home Manager configuration.
- `platform`: the target Nix platform string used for `pkgs`.
- `username`: the primary login user for this host.
- `description`: free-form documentation for humans.

## Host file responsibilities

`home.nix` owns the Home Manager identity directly:

```nix
{
  home.username = meta.username;
  home.homeDirectory = "/home/${meta.username}";
}
```

Do not inject the username through `specialArgs`. The host file should state it directly.

For system-managed hosts, `system.nix` should import `./meta.nix`, attach `./home.nix` through `custom.system.users.<name>.homeConfiguration`, and set any machine-specific system settings.

For `home-only` hosts, only `home.nix` is required.

## Creating a new host

1. Copy the closest existing host directory under `hosts/lh/`.
2. Edit `meta.nix` first and pick the right `kind`, `platform`, and `username`.
3. Write `home.nix` so it sets `home.username` and `home.homeDirectory` itself.
4. If the host is system-managed, add or update `system.nix` and point its user entry at `./home.nix`.
5. Add host-specific hardware files or platform settings only where they belong.
6. Evaluate the flake before building:

   ```bash
   nix eval .#homeConfigurations --apply builtins.attrNames
   nix eval .#nixosConfigurations --apply builtins.attrNames
   nix eval .#darwinConfigurations --apply builtins.attrNames
   ```

## Creating a new user on an existing host

If a host needs an additional user, add another entry under `custom.system.users` in that host's `system.nix` and give that user its own `homeConfiguration` path.

Keep the host-local `home.nix` files responsible for their own username and home directory. That keeps the flake discovery simple and avoids spreading identity through `specialArgs`.

## Notes

- The output key is the folder name, so rename the directory if you want a different flake attribute name.
- `home-only` hosts are included in `homeConfigurations` but skipped by the system builders.
- When you add a new host directory, make sure it lives under `hosts/lh/` so the current flake sees it.

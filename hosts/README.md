# Hosts

The flake now discovers host definitions from `hosts/*`. Each immediate subdirectory with a `meta.nix` file is one host, and the folder name becomes the flake output name.

## Layout

```text
hosts/
  lh/
    <host>/
      meta.nix
      home.nix
      system.nix
```

## `meta.nix`

Every host keeps a small metadata file next to its config files. The flake uses this file to decide how to build the host.

Typical shape:

```nix
{
  kind = "nixos"; # or "darwin" or "home"
  platform = "x86_64-linux";
  username = "lh";
  description = "Primary workstation";
}
```

Fields:

- `kind`: selects the builder.
  - `nixos` builds a NixOS system configuration.
  - `darwin` builds a nix-darwin system configuration.
  - `home` builds a Home Manager configuration.
- `platform`: the target Nix platform string used for `pkgs`.
- `username`: the primary login user for this host.
- `description`: free-form documentation for humans.

## Host file responsibilities

`system.nix` is the root of the host's system configuration when `kind` is `nixos` or `darwin`.

Typically, `system.nix` should set the stateVersion, import the hardware configuration, and set any machine-specific system settings. It could also attach `home.nix` to the primary user entry under `custom.system.users` if you want to enable Home Manager for that user.

You can also put the shared configuration under a subdirectory and import it from `system.nix`. For example, you could have a `base/` directory to hold the common configuration for all your NixOS hosts, and then import `../base/default.nix` from each host's `system.nix`.

Examples:

- [base configuration](./lh/base)
- [NixOS](./lh/msc-pc)
- [MacBook](./lh/msc-mbp)
- [WSL](./lh/desktop-wsl)
- [Home Manager Modules](./lh/docker)

## Creating a new host

1. Copy the closest existing host directory under `hosts/lh/`.
2. Edit `meta.nix` first and pick the right `kind`, `platform`, and `username`.
3. Write `system.nix` and `home.nix` for the new host, importing shared configuration as needed.
4. Add host-specific hardware files or platform settings only where they belong.
5. Evaluate the flake before building:

   ```bash
   nix eval .#homeConfigurations --apply builtins.attrNames
   nix eval .#nixosConfigurations --apply builtins.attrNames
   nix eval .#darwinConfigurations --apply builtins.attrNames
   ```

## Creating a new user on an existing host

The username set in `meta.nix` is the primary user for that host, which is used for homebrew, darwin preferences, etc.

If a host needs an additional user, add another entry under `custom.system.users` in that host's `system.nix` and give that user its own `homeConfiguration` path.

## Notes

- The output key is the folder name and supports deep paths, so rename the directory if you want a different flake attribute name.
- When you add a new host directory, make sure it has a `meta.nix` file so the current flake sees it.

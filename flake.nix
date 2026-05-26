{
  description = "Undefined01's everything about Nix, e.g., NixOS Configuration, customized packages, etc.";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable?shallow=1";
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable?shallow=1";
    };
    home-manager = {
      # url = "github:nix-community/home-manager/release-24.05";
      url = "github:nix-community/home-manager/master?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mutable-home-files = {
      url = "github:Undefined01/mutable-home-files";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # utils
    flake-compat = {
      url = "github:NixOS/flake-compat?shallow=1";
      flake = false;
    };
    nur = {
      url = "github:nix-community/NUR?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix for darwin
    darwin = {
      url = "github:LnL7/nix-darwin?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew?shallow=1";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle?shallow=1";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core?shallow=1";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask?shallow=1";
      flake = false;
    };

    # nix for wsl
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib.extend (final: prev: { custom = import ./lib { inherit (nixpkgs) lib; }; });

      forAllSystems = lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      listDirectories =
        path:
        lib.attrNames (
          lib.filterAttrs (_name: type: type == "directory") (builtins.readDir path)
        );

      hostRoot = ./hosts/lh;
      hostBaseHome = ./hosts/lh/base/home/default.nix;
      hostBaseSystem = ./hosts/lh/base/system/default.nix;
      hostEntries =
        listDirectories hostRoot
        |> map (
          name:
          let
            hostDir = lib.path.append hostRoot name;
          in
          {
            inherit name;
            meta = import (lib.path.append hostDir "meta.nix");
            systemPath = lib.path.append hostDir "system.nix";
            homePath = lib.path.append hostDir "home.nix";
          }
        )
        |> lib.filter (entry: entry.name != "base");
      systemHostEntries = lib.filter (entry: entry.meta.kind != "home-only" && lib.pathExists entry.systemPath) hostEntries;
      homeHostEntries = lib.filter (entry: lib.pathExists entry.homePath) hostEntries;

      buildSystemConfiguration =
        builder:
        entry:
        builder {
          specialArgs = {
            inherit lib;
            inherit inputs;
            inherit hostBaseHome;
            inherit hostBaseSystem;
            hostMeta = entry.meta;
            hostName = entry.name;
            isLinux = lib.strings.hasSuffix "-linux" entry.meta.platform;
            isDarwin = lib.strings.hasSuffix "-darwin" entry.meta.platform;
          };
          modules = [
            hostBaseSystem
            ./system
            entry.systemPath
          ];
        };

      buildHomeConfiguration =
        entry:
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${entry.meta.platform};
          extraSpecialArgs = {
            inherit inputs;
            customLib = lib.custom;
            inherit hostBaseHome;
            hostMeta = entry.meta;
            hostName = entry.name;
            isLinux = lib.strings.hasSuffix "-linux" entry.meta.platform;
            isDarwin = lib.strings.hasSuffix "-darwin" entry.meta.platform;
          };
          modules = [
            hostBaseHome
            ./home
            entry.homePath
          ];
        };

      nixosConfigurationEntries =
        map (
          entry:
          {
            inherit (entry) name meta;
            value = buildSystemConfiguration lib.nixosSystem entry;
          }
        ) (lib.filter (entry: entry.meta.kind == "nixos") systemHostEntries);
      darwinConfigurationEntries =
        map (
          entry:
          {
            inherit (entry) name meta;
            value = buildSystemConfiguration inputs.darwin.lib.darwinSystem entry;
          }
        ) (lib.filter (entry: entry.meta.kind == "darwin") systemHostEntries);
      homeConfigurationEntries =
        map (
          entry:
          {
            inherit (entry) name meta;
            value = buildHomeConfiguration entry;
          }
        ) homeHostEntries;

      nixosConfigurations = builtins.listToAttrs (map (entry: { inherit (entry) name value; }) nixosConfigurationEntries);
      darwinConfigurations = builtins.listToAttrs (map (entry: { inherit (entry) name value; }) darwinConfigurationEntries);
      homeConfigurations = builtins.listToAttrs (map (entry: { inherit (entry) name value; }) homeConfigurationEntries);

      # getSystemPackages =
      #   attr:
      #   if attr ? config then
      #     (attr.config.environment.systemPackages)
      #     ++ (lib.flatten (
      #       map (config: config.home.packages) (builtins.attrValues attr.config.home-manager.users)
      #     ))
      #   else
      #     lib.flatten (map getSystemPackages (builtins.attrValues attr));
      packagesToAttrset =
        list:
        builtins.listToAttrs (
          map (p: {
            name = p.name;
            value = p;
          }) list
        );
      getSystemPackages =
        attr:
        if attr ? config then
          {
            system = packagesToAttrset attr.config.environment.systemPackages;
            home = builtins.mapAttrs (
              name: value: packagesToAttrset value.home.packages
            ) attr.config.home-manager.users;
          }
        else
          builtins.mapAttrs (name: value: getSystemPackages value) attr;
      flatMapRecursive =
        cond: f: path: attr:
        if cond attr then
          lib.concatMapAttrs (name: value: flatMapRecursive cond f (path ++ [ name ]) value) attr
        else
          f path attr;
      flattenHierarchy =
        let
          isLeaf = attr: attr |> builtins.attrValues |> builtins.any (p: p ? type && p.type == "derivation");
          flattenHierarchy_ =
            prefix: attr:
            if isLeaf attr then
              [
                {
                  name = builtins.substring 1 (builtins.stringLength prefix) prefix;
                  value = attr;
                }
              ]
            else
              attr
              |> lib.attrsToList
              |> map ({ name, value }: flattenHierarchy_ "${prefix}-${name}" value)
              |> lib.flatten;
        in
        attr: flattenHierarchy_ "" attr |> builtins.listToAttrs;
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);

      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = builtins.attrValues self.overlays;
          };
        in
        lib.packagesFromDirectoryRecursive {
          callPackage = lib.callPackageWith pkgs;
          directory = ./pkgs;
        }
      );

      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = builtins.attrValues self.overlays;
          };
        in
        lib.packagesFromDirectoryRecursive {
          callPackage = lib.callPackageWith pkgs;
          directory = ./shell;
        }
      );

      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = nixosConfigurations;
      darwinConfigurations = darwinConfigurations;
      homeConfigurations = homeConfigurations;

      checks =
        let
          buildSystemPackageChecks =
            entries:
            builtins.listToAttrs (
              map (
                entry:
                {
                  name = entry.name;
                  value = {
                    system = packagesToAttrset entry.value.config.environment.systemPackages;
                    home = builtins.mapAttrs (
                      _: userConfig: packagesToAttrset userConfig.home.packages
                    ) entry.value.config.home-manager.users;
                  };
                }
              ) entries
            );

          buildSystemConfigurationChecks =
            platform:
            entries:
            builtins.listToAttrs (
              map (
                entry:
                {
                  name = entry.name;
                  value = if platform == "x86_64-linux" then entry.value.config.system.build.toplevel else entry.value.system;
                }
              ) entries
            );

          buildHomeConfigurationChecks =
            entries:
            builtins.listToAttrs (
              map (
                entry:
                {
                  name = entry.name;
                  value = entry.value.activationPackage;
                }
              ) entries
            );

          checksForPlatform =
            platform:
            let
              systemEntries =
                if platform == "x86_64-linux" then
                  lib.filter (entry: entry.meta.platform == platform) nixosConfigurationEntries
                else
                  lib.filter (entry: entry.meta.platform == platform) darwinConfigurationEntries;
              homeEntries = lib.filter (entry: entry.meta.platform == platform) homeConfigurationEntries;
            in
            {
              packages = buildSystemPackageChecks systemEntries;
              configurations = {
                system = buildSystemConfigurationChecks platform systemEntries;
                home = buildHomeConfigurationChecks homeEntries;
              };
            };
        in
        {
          x86_64-linux = checksForPlatform "x86_64-linux";
          aarch64-darwin = checksForPlatform "aarch64-darwin";
        };
    };
}

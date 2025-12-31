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
      inherit (self) outputs;

      lib = nixpkgs.lib.extend (final: prev: { custom = import ./lib { inherit (nixpkgs) lib; }; });

      forAllSystems = lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      defaultSystemSpecifier = {
        isLinux = false;
        isWsl = false;
        isDarwin = false;
      };
      buildSystemFromPath =
        {
          builder,
          path,
          specialArgs ? { },
        }:
        builtins.listToAttrs (
          map (host: {
            name = lib.removeSuffix ".nix" host;
            value = builder {
              specialArgs = {
                inherit inputs outputs lib;
              }
              // specialArgs;
              modules = [ (lib.path.append path host) ];
            };
          }) (builtins.attrNames (builtins.readDir path))
        );
      nixos = buildSystemFromPath {
        builder = lib.nixosSystem;
        path = ./system/top/nixos;
        specialArgs = defaultSystemSpecifier // {
          isLinux = true;
        };
      };
      wsl = buildSystemFromPath {
        builder = lib.nixosSystem;
        path = ./system/top/wsl;
        specialArgs = defaultSystemSpecifier // {
          isLinux = true;
          isWsl = true;
        };
      };
      darwin = buildSystemFromPath {
        builder = inputs.darwin.lib.darwinSystem;
        path = ./system/top/darwin;
        specialArgs = defaultSystemSpecifier // {
          isDarwin = true;
        };
      };

      home = lib.custom.callDirectoryRecursive {
        callFunc =
          host:
          inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = {
              user = "lh";
              inherit inputs outputs;
            };
            modules = [ host ];
          };
        directory = ./home/top;
      };
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

      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = nixos // wsl;
      darwinConfigurations = darwin;
      homeConfigurations = home;
    };
}

{
  description = "My Personal NixOS Configuration";

  nixConfig = {
    # substituters = "https://mirrors.ustc.edu.cn/nix-channels/store https://cache.nixos.org/";
  };

  inputs =
    {
      # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
      nixos-hardware.url = "github:nixos/nixos-hardware";
      nur = {
        url = "github:nix-community/NUR";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      home-manager = {
        # url = "github:nix-community/home-manager/release-24.05";
        url = "github:nix-community/home-manager/master";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nix-vscode-extensions = {
        url = "github:nix-community/nix-vscode-extensions";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # nix for darwin
      darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      nix-homebrew = {
        url = "github:zhaofengli-wip/nix-homebrew";
      };
      homebrew-bundle = {
        url = "github:homebrew/homebrew-bundle";
        flake = false;
      };
      homebrew-core = {
        url = "github:homebrew/homebrew-core";
        flake = false;
      };
      homebrew-cask = {
        url = "github:homebrew/homebrew-cask";
        flake = false;
      };
      homebrew-aerospace = {
        url = "github:nikitabobko/homebrew-aerospace";
        flake = false;
      };

      # nix for wsl
      nixos-wsl = {
        url = "github:nix-community/NixOS-WSL";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs = { self, nixpkgs, lib, ... }@inputs:
    let
      user = "lh";
      authorizedKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDcTQOKYRyLoviozP5Ba6k8N+1Sn7LZ1wECHiPa2FF1V amoscr@163.com" ];

      overlays = import ./overlays { inherit inputs; };
      specialArgs = {
        inherit self inputs user authorizedKeys;
      };

      forAllSystems = lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      defineNixOS = { systemArch, system, home, user ? null }:
        let
          isDarwin = lib.strings.hasPostfix systemArch "-darwin";
          systemDefineFunc =
            if isDarwin then
              inputs.darwin.lib.darwinSystem
            else
              lib.nixosSystem;
          homeManagerModule =
            if isDarwin then
              inputs.home-manager.darwinModules.home-manager
            else
              inputs.home-manager.nixosModules.home-manager;
        in
        systemDefineFunc {
          system = systemArch;
          specialArgs = specialArgs // lib.optionalAttr (user != null) { inherit user; };
          modules = [
            ./system/top/${system}
            homeManagerModule
            (import ./system/modules/home-manager/moduleBuilder.nix ./home/top/${home})
          ];
        };
    in
    {
      formatter = forAllSystems (system:
        nixpkgs.legacyPackages.${system}.nixpkgs-fmt
      );

      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );

      overlays = overlays;

      nixosConfigurations = {
        work = defineNixOS {
          systemArch = "x86_64-linux";
          system = "work";
          home = "work";
        };

        wsl = defineNixOS {
          systemArch = "x86_64-linux";
          system = "wsl";
          home = "commandline";
        };

        iso = defineNixOS {
          systemArch = "x86_64-linux";
          system = "work";
          home = "commandline";
        };
      };

      darwinConfigurations = {
        darwin = defineNixOS {
          systemArch = "aarch64-darwin";
          system = "darwin";
          home = "darwin";
          user = "han";
        };

        darwin-a = defineNixOS {
          systemArch = "aarch64-darwin";
          system = "darwin-a";
          home = "darwin-a";
        };
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations.darwin.pkgs;

      homeConfigurations.lh = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = specialArgs;
      };
    };
}

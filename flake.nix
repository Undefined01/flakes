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
      nur.url = "github:nix-community/NUR";
      home-manager = {
        # url = "github:nix-community/home-manager/release-24.05";
        url = "github:nix-community/home-manager/master";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      agenix = {
        url = "github:ryantm/agenix";
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

      # nix for wsl
      nixos-wsl = {
        url = "github:nix-community/NixOS-WSL";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      user = "lh";
      specialArgs = {
        inherit self inputs user;
        inherit (self) outputs;
      };

      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      overlays = import ./overlays { inherit inputs; };
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
        work = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs;
          modules = [
            ./configurations/work
            ./modules/home-manager/nixos
          ];
        };

        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs;
          modules = [
            ./configurations/wsl
            ./modules/home-manager/nixos
          ];
        };

        iso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs;
          modules = [
            ./configurations/iso
            ./modules/home-manager/nixos
          ];
        };
      };

      darwinConfigurations = {
        "Han-MacBook-Air" = inputs.darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = specialArgs // { user = "han"; };
          modules = [
            ./configurations/darwin
            ./modules/home-manager/darwin
          ];
        };
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Han-MacBook-Air".pkgs;
    };
}

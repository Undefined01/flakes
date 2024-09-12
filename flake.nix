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
      nixos-wsl = {
        url = "github:nix-community/NixOS-WSL";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # sops-nix = {
      #   url = "github:Mic92/sops-nix";
      #   inputs.nixpkgs.follows = "nixpkgs";
      # };
      agenix = {
        url = "github:ryantm/agenix";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nix-vscode-extensions = {
        url = "github:nix-community/nix-vscode-extensions";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # impermanence.url = "github:nix-community/impermanence";
      # hyprland = {
      #   url = "github:hyprwm/Hyprland";
      #   inputs.nixpkgs.follows = "nixpkgs";
      # };
    };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      user = "lh";

      inherit (self) outputs;
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
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs user; };
          modules = [
            { nixpkgs.overlays = builtins.attrValues overlays; }

            ./modules/home-manager
            ./configurations/common.nix
            ./configurations/nixos
          ];
        };

        work = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs user; };
          modules = [
            { nixpkgs.overlays = builtins.attrValues overlays; }

            ./modules/home-manager
            ./configurations/common.nix
            ./configurations/work
          ];
        };

        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs user; };
          modules = [
            { nixpkgs.overlays = builtins.attrValues overlays; }

            ./modules/home-manager
            ./configurations/common.nix
            ./configurations/wsl
          ];
        };

        iso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs user; };
          modules = [
            { nixpkgs.overlays = builtins.attrValues overlays; }

            ./modules/home-manager
            ./configurations/common.nix
            ./configurations/iso
          ];
        };
      };
    };
}

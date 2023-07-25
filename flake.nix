{
  description = "My Personal NixOS Configuration";

  nixConfig = { };

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
      nixos-hardware.url = "github:nixos/nixos-hardware";
      nur.url = "github:nix-community/NUR";
      impermanence.url = "github:nix-community/impermanence";
      home-manager = {
        url = "github:nix-community/home-manager/release-23.05";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      nixos-wsl = {
        url = "github:nix-community/NixOS-WSL";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
      # rust-overlay.url = "github:oxalica/rust-overlay";
      # nil.url = "github:oxalica/nil";
      # hyprpicker.url = "github:hyprwm/hyprpicker";
      # hypr-contrib.url = "github:hyprwm/contrib";
      # flake-parts.url = "github:hercules-ci/flake-parts";
      # sops-nix.url = "github:Mic92/sops-nix";
      # picom.url = "github:yaocccc/picom";
      hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      # flake-root.url = "github:srid/flake-root";
      # mission-control.url = "github:Platonic-Systems/mission-control";
      # treefmt-nix.url = "github:numtide/treefmt-nix";
      # emacs-overlay.url = "github:nix-community/emacs-overlay";
      # lanzaboote = {
      #   #please read this doc -> https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md 
      #   url = "github:nix-community/lanzaboote";
      #   inputs.nixpkgs.follows = "nixpkgs";
      # };
      # disko.url = "github:nix-community/disko";
      # emanote.url = "github:srid/emanote";
      # joshuto.url = "github:kamiyaa/joshuto";
      # go-musicfox.url = "github:go-musicfox/go-musicfox";
      # nixd.url = "github:nix-community/nixd";
      # flake-compat = {
      #   url = "github:inclyc/flake-compat";
      #   flake = false;
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
          specialArgs = { inherit inputs outputs user; };
          modules = [
            inputs.nur.nixosModules.nur
            { nixpkgs.overlays = builtins.attrValues overlays; }

            ./nixos/common.nix
            ./nixos/configuration.nix
            ./modules/impermanence
          ];
        };

        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs user; };
          modules = [
            "${inputs.nixos-wsl}/configuration.nix"
            inputs.nur.nixosModules.nur
            { nixpkgs.overlays = builtins.attrValues overlays; }

            ./nixos/common.nix
            ./presets/commandline
          ];
        };
      };

      homeConfigurations = {
        ${user} = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home-manager/home.nix ];
        };
      };
    };
}

{
  description = "Winston's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote.url = "github:nix-community/lanzaboote";

    # Non-NixOS inputs
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpaper.url = "github:hyprwm/hyprpaper";
    nix-gaming.url = "github:fufexan/nix-gaming";
    prismlauncher = {
      url = "github:LemonShaped/PrismLauncher-FTB";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    thorium.url = "github:almahdi/nix-thorium";
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      # NixOS on WSL
      biblichor = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          inputs.nixos-wsl.nixosModules.default
          inputs.vscode-server.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          ./modules/shared
          ./modules/biblichor
          {
            home-manager.users.wli = import ./home/biblichor;
          }
        ];
      };

      # NixOS on Framework 13
      theseus = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
          inputs.lanzaboote.nixosModules.lanzaboote
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          ./modules/shared
          ./modules/theseus
          {
            home-manager.users.wli = import ./home/theseus;
          }
        ];
      };
    };
  };
}

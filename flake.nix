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
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      # NixOS on WSL
      biblichor = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          inputs.nixos-wsl.nixosModules.default
          inputs.home-manager.nixosModules.home-manager

          ./root

          {
            networking.hostName = "wli-biblichor";

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.wli = import ./home;

            # Misc. WSL-specific settings
            programs.nix-ld.enable = true;

            wsl = {
              enable = true;
              defaultUser = "wli";
              startMenuLaunchers = true;
            };
          }
        ];
      };

      # NixOS on Framework 13
      theseus = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
          inputs.home-manager.nixosModules.home-manager
          inputs.lanzaboote.nixosModules.lanzaboote
          inputs.stylix.nixosModules.stylix

          ./root

          {
            networking.hostName = "wli-theseus";

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.wli = import ./home;

            # Secure boot
            bootspec.enable = true;

            loader.systemd-boot.enable = nixpkgs.lib.mkForce false;
            lanzaboote = {
              enable = true;
              pkiBundle = "/etc/secureboot";
            };
          }
        ];
      };
    };
  };
}

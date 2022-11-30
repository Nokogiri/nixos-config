{ lib, inputs, nixpkgs, user, sops-nix, nix-minecraft, home-manager, hyprland
, emacs-overlay, addins, ... }:

let
  system = "x86_64-linux"; # System architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true; # Allow proprietary software
  };

  lib = nixpkgs.lib;
in {
  frankenbook = lib.nixosSystem {
    # Desktop profile
    inherit system;
    specialArgs = { inherit inputs user; }; # Pass flake variable
    modules = [
      # Modules that are used.
      sops-nix.nixosModules.sops
      ./frankenbook
      ./configuration.nix
      {
        nixpkgs.overlays = [
          (self: super: {
            nix-direnv = super.nix-direnv.override { enableFlakes = true; };
          })
        ];
      }
    ];
  };
  mowteng = lib.nixosSystem {
    # Desktop profile
    inherit system;
    specialArgs = { inherit inputs user; }; # Pass flake variable
    modules = [
      # Modules that are used.
      sops-nix.nixosModules.sops
      hyprland.nixosModules.default
      ./mowteng
      ./configuration.nix
      {
        nixpkgs.overlays = [
          emacs-overlay.overlay
          addins.overlay
          (self: super: {
            nix-direnv = super.nix-direnv.override { enableFlakes = true; };
          })
        ];
      }
      home-manager.nixosModules.home-manager
      {
        # Home-Manager module that is used.
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; }; # Pass flake variable
        home-manager.users.${user} = {
          imports = [ (import ./home.nix) ] ++ [ (import ./mowteng/home.nix) ];
        };
      }
    ];
  };
  calvin = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      sops-nix.nixosModules.sops
      nix-minecraft.nixosModules.minecraft-servers
      ./calvin
      ./configuration.nix
      {
        nixpkgs.overlays = [
          nix-minecraft.overlay
          (self: super: {
            nix-direnv = super.nix-direnv.override { enableFlakes = true; };
          })
        ];
      }
    ];
  };
}

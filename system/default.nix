{ lib, inputs, nixpkgs, user, sops-nix, nix-minecraft, home-manager
, emacs-overlay, addins, spicetify-nix, ... }:

let
  system = "x86_64-linux"; # System architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true; # Allow proprietary software
  };

  lib = nixpkgs.lib;
in {
  homeassistant = lib.nixosSystem {
    # Desktop profile
    inherit system;
    specialArgs = { inherit inputs user; }; # Pass flake variable
    modules = [
      # Modules that are used.
      sops-nix.nixosModules.sops
      ./homeassistant
      ./configuration.nix
      {
        nixpkgs.overlays = [
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
          imports = [ (import ../home) ] # ++ (import ../home/homeassistant)
            ++ [ spicetify-nix.homeManagerModule ];
        };
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
        home-manager.extraSpecialArgs = {
          inherit user spicetify-nix;
        }; # Pass flake variable
        home-manager.users.${user} = {
          imports = [ (import ../home) ] ++ (import ../home/mowteng)
            ++ [ spicetify-nix.homeManagerModule ];
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
      home-manager.nixosModules.home-manager
      {
        # Home-Manager module that is used.
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; }; # Pass flake variable
        home-manager.users.${user} = {
          imports = [
            (import ../home)
          ] # ++ (import ../home/calvin) # Maybe in the future.
            ++ [ spicetify-nix.homeManagerModule ];
        };
      }

    ];
  };
}

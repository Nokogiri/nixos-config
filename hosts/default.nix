{ lib, inputs, nixpkgs, home-manager, user, sops-nix, emacs-overlay, addins, nix-minecraft, ... }:

let
  system = "x86_64-linux"; # System architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true; # Allow proprietary software
  };

  lib = nixpkgs.lib;
in
{
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
          emacs-overlay.overlay
          addins.overlay
          (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; })
        ];
      }
      home-manager.nixosModules.home-manager
      {
        # Home-Manager module that is used.
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; }; # Pass flake variable
        home-manager.users.${user} = {
          imports = [ (import ./home.nix) ] ++ [ (import ./frankenbook/home.nix) ];
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
          emacs-overlay.overlay
          addins.overlay
          nix-minecraft.overlay
          (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; })
        ];
      }
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [ (import ./home.nix) ];
        };

      }
    ];
  };
}

{ lib, inputs, nixpkgs, user, sops-nix, nix-minecraft, ... }:

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
          (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; })
        ];
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
          (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; })
        ];
      }
    ];
  };
}

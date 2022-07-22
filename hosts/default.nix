{ lib, inputs, nixpkgs, home-manager, nur, user, sops-nix, emacs-overlay, addins, nix-minecraft, ... }:

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
      nur.nixosModules.nur
      ./frankenbook
      ./configuration.nix
      {
        nixpkgs.overlays = [
          #hyprland.overlays.default
          emacs-overlay.overlay
          addins.overlay
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
          emacs-overlay.overlay
          addins.overlay
          nix-minecraft.overlay
          (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; })
        ];
      }
    ];
  };
}

{ lib, inputs, nixpkgs, home-manager, nur, user, hyprland, sops-nix, emacs-overlay, addins, newmpkg, pywm-fullscreenpkg, ... }:

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
      hyprland.nixosModules.default
      nur.nixosModules.nur
      ./frankenbook
      ./configuration.nix
      {
        nixpkgs.overlays = [
          hyprland.overlays.default
          emacs-overlay.overlay
          addins.overlay
          (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; })
          (self: super: {
            newm = newmpkg.packages.${system}.newm;
            pywm-fullscreen = pywm-fullscreenpkg.packages.${system}.pywm-fullscreen;
          })
        ];
      }
    ];
  };
  calvin = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      sops-nix.nixosModules.sops
      inputs.minecraft.nixosModules.minecraft-servers
      ./calvin
      ./configuration.nix
      {
        nixpkgs.overlays = [
          emacs-overlay.overlay
          hyprland.overlays.default
          addins.overlay
          inputs.nix-minecraft.overlay
          (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; })
        ];
      }
    ];
  };
}

{ config, pkgs, inputs, user, ... }:

{
  programs = {
    # Home-manager
    home-manager.enable = true;
  };

  nix = {
    # Nix Package Manager settings
    settings = {
      auto-optimise-store = true; # Optimise syslinks
    };
    package = pkgs.nixFlakes; # Enable nixFlakes on system
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true; # Allow proprietary software.
}

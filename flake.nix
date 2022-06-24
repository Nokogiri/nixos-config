{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
    };
    hyprland = {
      url = "github:vaxerski/Hyprland";
      # build with your own instance of nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
    addins-overlay = {
      url = "git+https://git.fishoeder.net/nokogiri/pkgs";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = inputs@{ self, nixpkgs, sops-nix, home-manager, emacs-overlay, hyprland, addins-overlay, ...}: {
    nixosConfigurations.frankenbook = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        #hyprland.nixosModules.default
        #{ programs.hyprland.enable =true; }
        ./default-modules.nix
        ./frankenbook/network.nix
        ./frankenbook/programs.nix
        ./frankenbook/retroarch.nix
        ./frankenbook/services.nix
        ./frankenbook/sway.nix
        ./frankenbook/sops.nix
        ./frankenbook/system.nix
        ./frankenbook/users.nix
        sops-nix.nixosModules.sops
        {
          nixpkgs.overlays = [
            emacs-overlay.overlay
            addins-overlay.overlay
          ];
        }
      ];
    };
  };
}

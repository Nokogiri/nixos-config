{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
      inputs.nixpgs.follows = "nixpkgs";
    };
    addins-overlay = {
      url = "git+https://codeberg.org/Nokogiri/nix-pkgs.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      # build with your own instance of nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , sops-nix
    , home-manager
    , emacs-overlay
    , addins-overlay
    , nix-minecraft
    , hyprland
    , ...
    }: {
      nixosConfigurations.frankenbook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./default-modules.nix
          ./frankenbook/network.nix
          ./frankenbook/programs.nix
          ./frankenbook/retroarch.nix
          ./frankenbook/services.nix
          ./frankenbook/sway.nix
          ./frankenbook/sops.nix
          ./frankenbook/system.nix
          ./frankenbook/users.nix
          hyprland.nixosModules.default
          sops-nix.nixosModules.sops
          {
            nixpkgs.overlays = [
              hyprland.overlays.default
              emacs-overlay.overlay
              addins-overlay.overlay
              (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; })
            ];
          }
        ];
      };
      nixosConfigurations.calvin = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./calvin/system.nix
          ./default-modules.nix
          ./calvin/environment.nix
          ./calvin/network.nix
          ./calvin/nginx.nix
          ./calvin/programs.nix
          ./calvin/services.nix
          ./calvin/sops.nix
          ./calvin/users.nix
          ./calvin/wireguard.nix
          sops-nix.nixosModules.sops
          nix-minecraft.nixosModules.minecraft-servers
          {
            nixpkgs.overlays = [
              nix-minecraft.overlay
              addins-overlay.overlay
            ];
          }
        ];
      };
    };
}

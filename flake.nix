{
  inputs = { 
    sops-nix.url = github:Mic92/sops-nix;
    # optional, not necessary for the module
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = github:nix-community/home-manager/master;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #emacs.url = "github:nix-community/emacs-overlay";
    emacs-overlay = {
      type = "github";
      owner = "nix-community";
      repo = "emacs-overlay";
    };
  };
  
  outputs = inputs@{ self, nixpkgs, sops-nix, home-manager, emacs-overlay, ...}: {
    # change `yourhostname` to your actual hostname
    nixosConfigurations.frankenbook = nixpkgs.lib.nixosSystem {
      # customize to your system
      system = "x86_64-linux";
      modules = [
        ./cachix.nix
        ./configuration.nix
        ./default-modules.nix
        ./frankenbook/system.nix
        ./frankenbook/network.nix
        ./frankenbook/programs.nix
        ./frankenbook/security.nix
        ./frankenbook/sops.nix
        ./frankenbook/sway.nix
        ./frankenbook/users.nix
        ./frankenbook/wireguard.nix
        ./modules/shell-programs.nix
        sops-nix.nixosModules.sops
        {
          nixpkgs.overlays = [
            emacs-overlay.overlay
          ];
        }
      ];
    };
  };
}

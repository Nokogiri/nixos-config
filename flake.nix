{
  inputs = { 
    sops-nix = {
      url = github:Mic92/sops-nix;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = github:nix-community/home-manager/master;
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        ./configuration.nix
        ./default-modules.nix
        ./frankenbook/emacs.nix
        ./frankenbook/fusuma.nix
        ./frankenbook/network.nix
        ./frankenbook/python.nix
        ./frankenbook/services.nix
        ./frankenbook/sway.nix
        ./frankenbook/sops.nix
        ./frankenbook/system.nix
        ./frankenbook/users.nix
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

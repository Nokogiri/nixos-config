{
  inputs = { 
    sops-nix.url = github:Mic92/sops-nix;
    # optional, not necessary for the module
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
        home-manager = {
      url = github:nix-community/home-manager/master;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, sops-nix, home-manager, ...}: {
    # change `yourhostname` to your actual hostname
    nixosConfigurations.frankenbook = nixpkgs.lib.nixosSystem {
      # customize to your system
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./frankenbook/hardware.nix
        sops-nix.nixosModules.sops
      ];
    };
  };
}

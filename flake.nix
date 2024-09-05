{
  description = "Home Manager configuration of admin";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
    };

    anyrun = {
      url = "github:Kirottu/anyrun";
    };

    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... } @ inputs: 
  let
    inherit (self) outputs; 
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs outputs; };

      modules = [
        nixos-hardware.nixosModules.lenovo-thinkpad-t490

	      ./configuration.nix

	      home-manager.nixosModules.home-manager
	      {
	        home-manager = {
	          extraSpecialArgs = { inherit inputs outputs; };

	          users.admin = import ./home.nix;
	        };
	      }
      ];
    };
  };
}

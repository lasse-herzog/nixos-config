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

    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = inputs@{ self, nixpkgs, nixos-hardware, home-manager, ags, anyrun, zen-browser, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = { inherit inputs; };
      modules = [
        nixos-hardware.nixosModules.lenovo-thinkpad-t490

	      ./configuration.nix

	      home-manager.nixosModules.home-manager
	      {
          home-manager = {
            extraSpecialArgs = { inherit inputs; };
            useGlobalPkgs = true;
            useUserPackages = true;
            users.admin = import ./home.nix;
	        };
        }
      ];
    };
  };
}

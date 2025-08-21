{
  description = "Home Manager configuration of admin";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:yaxitech/ragenix";

    ags.url = "github:aylur/ags";

    catppuccin.url = "github:catppuccin/nix";

    hyprland.url = "github:hyprwm/hyprland";

    musnix.url = "github:musnix/musnix";

    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    prismlauncher.url = "github:prismlauncher/prismlauncher";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    mysecrets = {
      url = "git+ssh://git@github.com/lasse-herzog/nix-secrets.git";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    ags,
    catppuccin,
    musnix,
    nvchad4nix,
    prismlauncher,
    spicetify-nix,
    zen-browser,
    ...
  } @ inputs: let
    inherit (inputs.nixpkgs) lib;
    inherit (inputs) agenix mysecrets;
    inherit (self) outputs;

    mylib = import ./lib {inherit lib;};
    myvars = import ./vars {inherit lib;};
  in {
    #
    # ========= Host Configurations =========
    #
    # Building configurations is available through `just rebuild` or `nixos-rebuild --flake .#hostname`
    nixosConfigurations = builtins.listToAttrs (
      map (host: {
        name = host;
        value = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit mylib mysecrets myvars agenix inputs outputs;};
          modules = [./hosts/${host}];
        };
      }) (builtins.attrNames (builtins.readDir ./hosts))
    );
  };
}

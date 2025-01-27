{
  description = "Home Manager configuration of admin";

  nixConfig = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org" # Hyprland Cachix
      "https://prismlauncher.cachix.org" # Prism Launcher Cache
      #"https://cuda-maintainers.cachix.org"
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" # Hyprland Cachix
      "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c=" # Prism Launcher Cache
      #"cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:aylur/ags";

    catppuccin.url = "github:catppuccin/nix";

    hyprland.url = "github:hyprwm/hyprland";

    musnix.url = "github:musnix/musnix";

    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    prismlauncher.url = "github:prismlauncher/prismlauncher";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
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

    mylib = import ./lib {inherit lib;};
    myvars = import ./vars {inherit lib;};

    specialArgs = {inherit mylib myvars inputs;};
  in {
    nixosConfigurations = {
      midgard = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = specialArgs;
        modules = [
          nixos-hardware.nixosModules.common-cpu-amd-pstate
          nixos-hardware.nixosModules.common-pc-ssd

          musnix.nixosModules.musnix

          catppuccin.nixosModules.catppuccin

          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              backupFileExtension = "backup";
              extraSpecialArgs = specialArgs;

              useGlobalPkgs = true;
              useUserPackages = true;

              users.admin.imports = [
                ./home/home.nix
                catppuccin.homeManagerModules.catppuccin
                nvchad4nix.homeManagerModule
                spicetify-nix.homeManagerModules.default
              ];
            };
          }
        ];
      };
    };
  };
}

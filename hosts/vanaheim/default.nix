{
  nixpkgs,
  inputs,
  specialArgs,
  mylib,
  lib,
  ...
}: {
  imports = lib.flatten [
    ./hardware-configuration.nix
    inputs.agenix.nixosModules.default

    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    inputs.catppuccin.nixosModules.catppuccin
    inputs.musnix.nixosModules.musnix

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        backupFileExtension = "backup";
        extraSpecialArgs = specialArgs;

        useGlobalPkgs = true;
        useUserPackages = true;

        users.admin.imports =
          (map mylib.relativeToRoot [
            "home/home.nix"
          ])
          ++ [
            inputs.catppuccin.homeModules.catppuccin
            inputs.nvchad4nix.homeManagerModule
            inputs.spicetify-nix.homeManagerModules.default
            inputs.zen-browser.homeModules.twilight
          ];
      };
    }

    (map mylib.relativeToRoot [
      "modules/configuration.nix"
    ])
  ];
}

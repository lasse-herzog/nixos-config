{
  inputs,
  specialArgs,
  mylib,
  lib,
  ...
}: {
  networking.hostName = "midgard";

  imports = lib.flatten [
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-turing
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ./hardware-configuration.nix

    inputs.agenix.nixosModules.default
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
      "secrets"
    ])
  ];
}

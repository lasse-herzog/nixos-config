{
  inputs,
  specialArgs,
  mylib,
  lib,
  ...
}: {
  networking.hostName = "vanaheim";

  environment.sessionVariables = {
    WLR_DRM_DEVICES = "/dev/dri/card1";
  };

  imports = lib.flatten [
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
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
      "modules/laptop/default.nix"
      "modules/bluetooth.nix"
    ])
  ];
}

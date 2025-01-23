{
  lib,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
    ];

  programs = {
    steam = {
      enable = true;

      gamescopeSession.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    lutris
    mangohud

    wineWowPackages.waylandFull
    winetricks
  ];
}

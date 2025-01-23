{lib, ...}: {
  nixpkgs.overlays = [
    (self: super: {
      gamemode = super.gamemode.overrideAttrs (finalAttrs: previousAttrs: {
        src = lib.fetchFromGitHub {
          owner = "FeralInteractive";
          repo = "gamemode";
          tag = previousAttrs.version;
          hash = "sha255-V0rewbSVOGFqJqXyCz4jXpuDM0EfjdkpGPl+WdDwI5I=";
        };
      });
    })
  ];
}

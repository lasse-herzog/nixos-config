{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.overlays = [
    inputs.prismlauncher.overlays.default
    (self: super: {
      gamemode = super.gamemode.overrideAttrs (finalAttrs: previousAttrs: {
        src = pkgs.fetchFromGitHub {
          owner = "FeralInteractive";
          repo = "gamemode";
          tag = previousAttrs.version;
          hash = "sha256-V0rewbSVOGFqJqXyCz4jXpuDM0EfjdkpGPl+WdDwI5I=";
        };
      });
    })

    (self: super: {
      #glfw3-minecraft = super.glfw3-minecraft.overrideAttrs (finalAttrs: previousAttrs: {
      #  patches = [
      #    #(super.fetchpatch {
      #    #  url = "https://raw.githubusercontent.com/Admicos/minecraft-wayland/refs/heads/main/0003-Don-t-crash-on-calls-to-focus-or-icon.patch";
      #    #  sha256 = "sha256-3U/nzFUI8nz3ixxhRFzgppoWH62kNMlGJnXSaJPbtRY=";
      #    #  #excludes = [ ".SRCINFO" "PKGBUILD" "README.md" ];
      #    #})
      #    (super.fetchpatch {
      #      url = "https://raw.githubusercontent.com/Admicos/minecraft-wayland/refs/heads/main/0004-wayland-fix-broken-opengl-screenshots-on-mutter.patch";
      #      sha256 = "sha256-ZVlnXZkqp7B5WZzzkMGjAyYvjmidlZyYvpa0z3GNW4U=";
      #      #excludes = [ ".SRCINFO" "PKGBUILD" "README.md" ];
      #    })
      #    (super.fetchpatch {
      #      url = "https://raw.githubusercontent.com/Admicos/minecraft-wayland/refs/heads/main/0005-Add-warning-about-being-an-unofficial-patch.patch";
      #      sha256 = "sha256-j/z6c/bGKFtCwBvIVNGi63xa+7yIF1mRKc9q3Ykigaw=";
      #      #excludes = [ ".SRCINFO" "PKGBUILD" "README.md" ];
      #    })
      #  ];
      #});
    })
  ];
}

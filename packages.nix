{ pkgs, lib, inputs, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "jetbrains-toolbox"
    "obsidian"
    "ticktick"
    "webstorm"
  ];

  home.packages = with pkgs; [
    linux-wifi-hotspot

    ticktick
    inputs.zen-browser.packages."${system}".specific

    zed-editor
    zotero-beta

    jetbrains.webstorm
    
    bun
    go
  ];

  xdg = {
    desktopEntries = {
      jetbrains-toolbox = {
        name = "JetBrains Toolbox";
        exec = "jetbrains-toolbox -enable-features=UseOzonePlatform -ozone-platform=wayland %U";
        icon = "jetbrains-toolbox";
      };

      obsidian = {
        name = "Obsidian";
        exec = "obsidian -enable-features=UseOzonePlatform -ozone-platform=wayland %U";
        icon = "obsidian";
      };

      ticktick = {
        name = "TickTick";
        exec = "ticktick -enable-features=UseOzonePlatNixOSform -ozone-platform=wayland %U";
        icon = "ticktick";
      };

      /*zotero = {
        name = "Zotero";
        exec = "MOZ_ENABLE_WAYLAND=1 zotero %U";
        icon = "zotero";
      };*/
    };
  };
}

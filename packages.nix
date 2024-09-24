{ lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "jetbrains-toolbox"
    "obsidian"
    "pycharm-professional"
    "ticktick"
    "webstorm"
  ];

  home.packages = with pkgs; [
    linux-wifi-hotspot
    unar
    wkhtmltopdf
   
    protonvpn-gui
    obsidian
    ticktick
    zed-editor
    zotero-beta
    
    jetbrains.pycharm-professional
    jetbrains.webstorm
    
    bun
    flutter
    go
    nodejs_22
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

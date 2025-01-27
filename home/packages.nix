{
  lib,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    libnotify
    inputs.zen-browser.packages."${system}".default # Zen browser from flake

    linux-wifi-hotspot
    pdfannots2json # for zotero integration obsdidian plugin
    unar
    vlc
    wkhtmltopdf
    wl-clipboard
    # clipboard-jh # the clipboard project clipboard manager

    motrix
    # protonvpn-gui currently broken because of apt
    obsidian
    zotero-beta
    vesktop # Vencord desktop client

    pinentry-curses # for gpg authenticatio

    prismlauncher

    bun
  ];

  programs = {
    aria2 = {
      enable = true;
    };

    gpg = {
      enable = true;

      publicKeys = [{source = ./8BC36B1CA95F880D371163AB531DF6622FE41C3F.asc;}];
    };

    mpv = {
      enable = true;
    };

    nvchad = {
      enable = true;
    };

    spotify-player.enable = true;
  };

  services = {
    # notification agent
    dunst = {
      enable = true;
    };

    gammastep = {
      enable = true;

      latitude = "48.399620";
      longitude = "9.996610";
    };

    gpg-agent = {
      enable = true;

      enableSshSupport = true;
      pinentryPackage = pkgs.pinentry-curses;
      sshKeys = ["3DE487830BEEE3DB641EA517DECEE352B96629E0"];
    };
  };

  home.sessionVariables.DEFAULT_BROWSER = "${inputs.zen-browser.packages."${pkgs.system}".default}/bin/zen";

  xdg = {
    desktopEntries = {
      obsidian = {
        name = "Obsidian";
        exec = "obsidian -enable-features=UseOzonePlatform -ozone-platform=wayland %U";
        icon = "obsidian";
      };
    };

    mimeApps = {
      enable = true;

      defaultApplications = {
        "text/html" = "zen.desktop";
        "x-scheme-handler/http" = "zen.desktop";
        "x-scheme-handler/https" = "zen.desktop";
        "x-scheme-handler/about" = "zen.desktop";
        "x-scheme-handler/unknown" = "zen.desktop";
      };
    };
  };
}

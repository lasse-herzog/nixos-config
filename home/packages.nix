{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    libnotify
    linux-wifi-hotspot
    pdfannots2json # for zotero integration obsdidian plugin
    unar
    vlc
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
    zathura

    (clementine.override
      {
        config = config // {config.clementine.ipod = true;};
      })
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
      pinentry.package = pkgs.pinentry-curses;
      sshKeys = ["3DE487830BEEE3DB641EA517DECEE352B96629E0"];
    };
  };

  home.sessionVariables.DEFAULT_BROWSER = "${inputs.zen-browser.packages."${pkgs.system}".twilight}/bin/zen";

  xdg = {
    desktopEntries = {
      obsidian = {
        name = "Obsidian";
        exec = "obsidian -enable-features=UseOzonePlatform -ozone-platform=wayland %U";
        icon = "obsidian";
      };
    };
  };
}

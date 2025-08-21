{...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  services = {
    hyprpaper = {
      enable = true;

      settings = {
        ipc = "off";

        preload = ["/home/admin/Downloads/mpd_cover.png"];

        wallpaper = [
          ", contain:/home/admin/Downloads/mpd_cover.png"
        ];
      };
    };

    hyprpolkitagent.enable = true;

    hyprsunset.enable = true;
  };

  programs.hyprlock = {
    enable = true;
  };
}

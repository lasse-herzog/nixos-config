{pkgs, ...}: {
  home.packages = with pkgs; [
    hyprpolkitagent
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;

    systemd.extraCommands = [
      "systemctl --user start hyprpolkitagent"
    ];
  };
}

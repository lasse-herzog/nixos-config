{config, ...}: let
  cfg = config.programs.hyprland;
in {
  wayland.windowManager.hyprland = {
    enable = true;
  };
}

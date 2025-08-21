{...}: {
  # Turns your tablet into a drawing tablet
  programs.weylus = {
    enable = true;
    users = ["admin"];
    openFirewall = true;
  };
}

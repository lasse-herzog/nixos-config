{pkgs, ...}: {
  programs.rbw = {
    enable = true;
    settings = {
      email = "lasse@herzoeglich.de";
      pinentry = pkgs.pinentry-tty;
    };
  };
}

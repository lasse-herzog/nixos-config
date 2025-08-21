{pkgs, ...}: {
  services.printing = {
    enable = true;

    drivers = with pkgs; [epson-escpr epson-escpr2];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}

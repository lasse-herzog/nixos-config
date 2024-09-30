{ pkgs, ... } :
{
  home.packages = [ pkgs.libsecret ];
  services.gnome-keyring.enable = true;
}

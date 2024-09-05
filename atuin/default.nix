{ pkgs, ... }:

{
  home.packages = [ pkgs.atuin ];

  programs.atuin = {
    enable = true;
  };
}

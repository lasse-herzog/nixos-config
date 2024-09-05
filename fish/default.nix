{ pkgs, ... }:

{
  home.packages = [ pkgs.fish ];

  programs.fish = {
    enable = true;

    functions = {

    };

    interactiveShellInit = "set fish_greeting";

    shellAbbrs = {

    };

    shellAliases = {

    };

    shellInit = "";
    shellInitLast = "";
  };
}

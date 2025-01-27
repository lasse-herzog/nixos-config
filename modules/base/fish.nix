{...}: {
  programs.fish = {
    enable = true;

    shellInit = "";

    interactiveShellInit = "set fish_greeting";

    shellAbbrs = {
    };

    shellAliases = {
    };
  };
}

{ pkgs, inputs, anyrun, ... }:

{
  programs.anyrun = {
    enable = true;

    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
      ];
    };
  };
}

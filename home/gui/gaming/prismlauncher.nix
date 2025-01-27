{pkgs}: {
  home.packages = with pkgs; [
    primlauncher
  ];

  home.sessionVariables = {
    __GL_THREADED_OPTIOMIZATIONS = 0; # https://github.com/CaffeineMC/sodium/wiki/Driver-Compatibility#nvidia-threaded-optimizations-linux
  };
}

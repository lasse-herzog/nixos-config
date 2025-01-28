{pkgs, ...}: {
  home.packages = with pkgs; [
    prismlauncher
  ];

  home.sessionVariables = {
    __GL_THREADED_OPTIMIZATIONS = 0; # https://github.com/CaffeineMC/sodium/wiki/Driver-Compatibility#nvidia-threaded-optimizations-linux
  };
}

{ config, inputs, pkgs, lib, ... }:

{
  imports = [
    ./ags
    ./anyrun
    ./fish
    ./foot
    ./nnn
    ./starship
    ./wlogout
    ./packages.nix
    ./theme.nix
  ];
  
  

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "admin";
  home.homeDirectory = "/home/admin";
  
  home.enableNixpkgsReleaseCheck = false;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    brave
    jetbrains-toolbox

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    nodejs
    obsidian

    texlive.combined.scheme-full
    libreoffice-fresh

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    waylogout # logout functionality
    
    floorp
    git

    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # ".config/nvim".source = fetchFromGitHub {
    #   owner = "NvChad";
    #   repo = "starter";
    #   rev = "refs/heads/main";
    #   sha256 = "sha256-2HNqPdnIVkX+d5OxjsRbL3SoY8l5Ey7/Y274Pi5uZW4=";
    # };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #sbl  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/admin/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    MOZ_ENABLE_WAYLAND=1;
  };
   
  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userEmail="lasse@herzoeglich.de";
      userName="Lasse Herzog";
    };

    neovim = {
      enable = true;
    };
  };

  xdg.portal = {
    enable = true;

    config.common.default = [
      "wlr"
      "gtk"
    ];
    
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
}

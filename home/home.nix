{
  pkgs,
  osConfig,
  ...
}: {
  imports = [
    ./gui.nix
    ./packages.nix
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

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    nerd-fonts.jetbrains-mono
  ];

  home.file = {
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
    MOZ_ENABLE_WAYLAND = 1;
    CLIPBOARD_NOGUI = 1;
    LUA_PATH = ""; # Workaround for avante nvim plugin
#    OPENAI_API_KEY = "$(cat ${osConfig.age.secrets.openai_api_key.path})";
  };

  programs = {
    git = {
      enable = true;
      userEmail = "lasse@herzoeglich.de";
      userName = "Lasse Herzog";
      extraConfig = {
        credential.helper = "${
          pkgs.git.override {withLibsecret = true;}
        }/bin/git-credential-libsecret";
      };
    };
  };

  xdg.portal = {
    enable = true;

    config.common.default = ["hyprland"];
  };

  catppuccin = {
    enable = true;
    accent = "lavender";
    flavor = "frappe";
  };
}

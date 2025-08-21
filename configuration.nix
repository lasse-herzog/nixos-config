{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./overlays.nix
    # ./gaming.nix
    ./audio.nix
    ./hardware-configuration.nix
    ./nix.nix
    ./nvidia.nix
    ./podman.nix
    ./modules/desktop.nix
  ];

  nix = {
    settings = {
      # enable flakes globally
      experimental-features = ["nix-command" "flakes"];

      # given the users in this list the right to specify additional substituters via:
      #    1. `nixConfig.substituers` in `flake.nix`
      #    2. command line args `--options substituers http://xxx`
      # trusted-users = [myvars.username];

      # substituers that will be considered before the official ones(https://cache.nixos.org)
      substituters = [
        "https://nix-community.cachix.org"
        # my own cache server, currently not used.
        # "https://ryan4yin.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        # "ryan4yin.cachix.org-1:Gbk27ZU5AYpGS9i3ssoLlwdvMIh0NxG0w8it/cv9kbU="
      ];

      builders-use-substitutes = true;
    };
    # perform garbage collection weekly
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };

    settings.auto-optimise-store = true;
  };

  programs.hyprland.enable = true;

  # Bootloader.
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        configurationLimit = 1;
      };
    };

    # binfmt.emulatedSystems = [ "aarch64-linux" ];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  allowedUnfreePackages = [
    # CUDA support
    "cuda_cudart"
    "cuda_cccl"
    "cuda_nvcc"
    "libcublas"
    "libcufft"
    "libnpp"

    "nvidia-x11"
    "nvidia-settings"
    "nvidia-persistenced"
    "obsidian"
    "open-webui"
    "spotify"
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) config.allowedUnfreePackages;

  # Enable networking
  networking = {
    hostName = "midgard"; # Define your hostname.

    networkmanager.enable = true;

    firewall = {
      logReversePathDrops = true;
      # wireguard trips rpfilter up
      extraCommands = ''
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
      '';
      extraStopCommands = ''
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
      '';
    };
  };

  hardware.graphics = {
    enable = true;
    # enable32Bit = true;

    # for Lutris
    extraPackages = with pkgs; [
      # rocm-opencl-icd
      # rocm-opencl-runtime
    ];
  };

  #Bluetooth
  hardware.bluetooth = {
    enable = false;
    # powerOnBoot = true;
  };

  # KeyBoard
  hardware.keyboard = {
    qmk.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    groups = {
      admin = {};
    };

    users = {
      admin = {
        isNormalUser = true;
        description = "admin";
        group = "admin";
        extraGroups = ["networkmanager" "podman" "wheel"];
        shell = pkgs.fish;
        packages = with pkgs; [];
      };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      inputs.agenix.packages.x86_64-linux.default
      gparted # graphical partition manager
      # pmount
      polkit_gnome # graphical polkit authentication agent
      udisks
      usbimager # put iso on usb
      via
    ];
  };

  security = {
    rtkit.enable = true;

    # wrappers = {
    #   pmount = {
    #     setuid = true;
    #     owner = "root";
    #     group = "root";
    #     source = "${pkgs.pmount}/bin/pmount";
    #   };

    #   pumount = {
    #     setuid = true;
    #     owner = "root";
    #     group = "root";
    #     source = "${pkgs.pmount}/bin/pumount";
    #   };
    # };
  };

  # List services that you want to enable:
  services = {
    displayManager.ly = {
      enable = true;
      settings = {
        clock = "%c";
      };
    };

    #ollama = {
    #  enable = true;
    #
    #  acceleration = "cuda";

    #  environmentVariables = {
    #    CUDA_VISIBLE_DEVICES = "0";
    #    OLLAMA_ORIGINS = "app://obsidian.md*";
    #  };

    #  loadModels = [
    #    "qwen2.5:7b"
    #  ];
    #};

    # UDev rules
    udev.packages = [
      pkgs.via
    ];

    udisks2 = {
      enable = true;
    };

    upower.enable = true;

    stirling-pdf = {
      enable = false;
      environment = {
        SERVER_PORT = 9000;
      };
    };
  };

  catppuccin = {
    enable = true;
    flavor = "frappe";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

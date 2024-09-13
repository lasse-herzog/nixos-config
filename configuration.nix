# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./podman.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    
    # perform garbage collection weekly
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };

    settings.auto-optimise-store = true;
  };
  
  # Bootloader.
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;

      grub = {
        enable = true;
        configurationLimit = 10;
        device = "nodev";
      };
    };

    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking = {
    hostName = "nixos"; # Define your hostname.

    enableIPv6  = false;

    #nameservers = [
    #  ""
    #];

    networkmanager.enable = true;

    firewall = {
      #checkReversePath = false; 

      #allowedTCPPorts = [ 51820 ]; # For WireGuard protocol
      #allowedUDPPorts = [ 51820 ]; # For WireGuard protocol
      # if packets are still dropped, they will show up in dmesg
      logReversePathDrops = true;
      # wireguard trips rpfilter up
      extraCommands = ''
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
      '';
     #  ip46tables -t mangle -I nixos-fw-rpfilter -p tcp -m tcp --sport 51820 -j RETURN
     #  ip46tables -t mangle -I nixos-fw-rpfilter -p tcp -m tcp --dport 51820 -j RETURN
      extraStopCommands = ''
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
      '';
     #  ip46tables -t mangle -D nixos-fw-rpfilter -p tcp -m tcp --sport 51820 -j RETURN || true
     #  ip46tables -t mangle -D nixos-fw-rpfilter -p tcp -m tcp --dport 51820 -j RETURN || true
    };

    #wireguard.interfaces = {
    #  wg0 = {
    #    ips = [ "10.2.0.2/32" ];
    #    listenPort = 51820;

    #    privateKeyFile = "./wg_privatekey";

    #    peers = [
    #      {
    #        publicKey = Ky8glqH9vHhIoSgiKcNv0q6o0qRsjCMV5S3I2v/j6w4=;
    #        allowedIps = [ "0.0.0.0/0" ];
    #        endpoint = "185.183.34.27:51820";
    #      }
    #    ];
    #  };
    #};
  };

  #Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  
  # KeyBoard
  hardware.keyboard = {
    qmk.enable = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-ocl
      libvdpau-va-gl
    ];
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
  
  # UDev rules
  services.udev.packages = [
    pkgs.via
  ];

  # Configure keymap in X11
  # services.xserver = {
  #   layout = "de";
  #   xkbVariant = "nodeadkeys";
  # };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    groups = {
      admin = { };
    };

    users = {
      admin = {
        isNormalUser = true;
        description = "admin";
        group = "admin";
        extraGroups = [ "networkmanager" "podman" "wheel" ];
        packages = with pkgs; [];
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs = {
    river.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  #  anyrun
      #xorg.libX11
      pmount
      foot
      #libGL
      udisks
      via
      #egl-wayland
      #firefox
    ];

    sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
      VDPAU_DRIVER = "va_gl";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  security= {
    rtkit.enable = true;

    wrappers = {
      pmount = {
        setuid = true;
        owner = "root";
        group = "root";
        source = "${pkgs.pmount}/bin/pmount"; 
      };

      pumount = {
        setuid = true;
        owner = "root";
        group = "root";
        source = "${pkgs.pmount}/bin/pumount";
      };
    };
  };

  # List services that you want to enable:
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      wireplumber = {
        enable = true;
      };
    };

    udisks2 = {
      enable = true;
    };

    upower.enable = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  
  #specialisation = {
  #  gnome.configuration = {
  #    system.nixos.tags = ["Gnome"];
  #    # hyprland.enable = lib.mkForce false;
  #    gnome.enable = true;
  #  };
  #};


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

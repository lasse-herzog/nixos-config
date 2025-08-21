{...}: {
  musnix.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    extraConfig.pipewire = {
      "10-clock" = {
        "context.properties" = {
          "default.clock.rate" = 44100;
          "default.clock.allowed-rates" = [44100 48000 88200 96000 192000];
          "default.clock.quantum" = 128;
        };
      };
    };

    wireplumber = {
      enable = true;
      extraConfig = {
        "10-scartlett-2i2" = {
          "monitor.alsa.rules" = [
            {
              matches = [
                {
                  "device.nick" = "Focusrite Scarlett 2i2 USB";
                }
              ];

              actions = {
                update-props = {
                  "api.acp.probe-rate" = "44100";
                };
              };
            }
          ];
        };
      };
    };
  };

  users.users.admin.extraGroups = ["audio"];
}

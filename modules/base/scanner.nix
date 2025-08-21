{...}: {
  hardware.sane = {
    enable = true;

    drivers.scanSnap.enable = true;
  };

  allowedUnfreePackages = ["scansnap-firmware"];

  services.ipp-usb.enable = true;

  users.users.admin.extraGroups = ["scanner"];
}

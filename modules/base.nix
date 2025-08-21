{lib, ...}: {
  # Option to whitelist certain unfree packages
  options.allowedUnfreePackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
  };
}

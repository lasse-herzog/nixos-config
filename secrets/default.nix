# import & decrypt secrets in `mysecrets` in this module
{
  agenix,
  mysecrets,
  ...
}: {
  imports = [
    agenix.nixosModules.default
  ];

  # if you changed this key, you need to regenerate all encrypt files from the decrypt contents!
  age.identityPaths = [
    # using the host key for decryption
    # the host key is generated on every host locally by openssh, and will never leave the host.
    "/etc/ssh/ssh_host_ed25519_key"
  ];

  age.secrets."herzoeglich_email" = {
    # whether secrets are symlinked to age.secrets.<name>.path, defaults to true
    # symlink = true;
    # target path for decrypted file
    # path = "/etc//";
    # encrypted file path
    file = "${mysecrets}/herzoeglich_email.age"; # refer to ./xxx.age located in `mysecrets` repo
    mode = "0400";
    owner = "root";
    group = "root";
  };
}

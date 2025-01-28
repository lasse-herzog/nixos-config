{...}: {
  programs.ssh = {
    startAgent = true;

    extraConfig = ''
      Host github.com
        IdentityFile /home/admin/.ssh/id_ed25519
    '';
  };
}

{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.msmtp.enable = true;
  programs.neomutt.enable = true;

  home.packages = with pkgs; [
    lynx
  ];

  home.file.".mailcap" = {
    enable = true;

    text = ''
      text/html; lynx %s
    '';
  };

  accounts.email.accounts = {
    "herzoeglich" = {
      primary = true;
      address = "lasse@herzoeglich.de";
      userName = "lasse@herzoeglich.de";
      realName = "Lasse Herzog";
      passwordCommand = "${lib.getExe config.programs.rbw.package} get lasse@herzoeglich.de -f password";

      imap = {
        host = "imap.1und1.de";
      };

      smtp = {
        host = "smtp.1und1.de";
      };

      mbsync = {
        enable = true;
        create = "imap";
      };

      msmtp = {
        enable = true;
      };

      neomutt = {
        enable = true;
        mailboxType = "imap";
      };
    };
  };
}

{
  lib,
  config,
  ...
}: {
  programs.neomutt.enable = true;

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

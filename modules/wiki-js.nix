{pkgs, ...}: {
  services.postgresql = {
    enable = true;

    ensureDatabases = ["wikijs"];

    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';

    ensureUsers = [
      {
        name = "wikijs";
        ensureDBOwnership = true;
      }
    ];
  };

  services.wiki-js = {
    enable = true;

    settings = {
      db.host = "/run/postgresql";
      db.db = "wikijs";
    };
  };
}

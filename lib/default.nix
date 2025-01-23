{lib, ...}: {
  relativeToRoot = lib.path.append ../.;

  # includes directories and .nix files
  scanPaths = path:
    builtins.map (f: (path + "/${f}"))
    (builtins.attrNames (
      lib.attrsets.filterAttrs (
        path: _type:
          (_type == "directory")
          || ((path != "default.nix")
            && (lib.strings.hasSuffix ".nix" path))
      ) (builtins.readDir path)
    ));
}

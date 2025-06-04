{
  config,
  symlinks,
  text ? {},
}:
(builtins.listToAttrs (
  builtins.map (x: {
    name = x;
    value.source = config.lib.file.mkOutOfStoreSymlink "/nix/persist${config.home.homeDirectory}/${x}";
  })
  symlinks
))
// text

{
  fill-with = {
    value,
    keys,
  }: (builtins.listToAttrs (
    builtins.map (x: {
      name = x;
      value = value;
    })
    keys
  ));

  persist = {
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
    // text;
  # (builtins.map (x: {
  #     text = x;
  #   })
  #   text);
}

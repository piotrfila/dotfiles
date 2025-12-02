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
    files ? [],
    directories ? [],
  }: {
    "/nix/persist${config.home.homeDirectory}" = {
      removePrefixDirectory = false;
      allowOther = true;
      directories = directories;
      files = files;
    };
  };
}

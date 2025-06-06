{
  value,
  keys,
}: (builtins.listToAttrs (
  builtins.map (x: {
    name = x;
    value = value;
  })
  keys
))

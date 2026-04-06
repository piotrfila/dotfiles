{
  config,
  pkgs,
  ...
}: let
  unstable = import <nixos-unstable> {};
  util = import ../util.nix;
in {
  home = {
    packages = [unstable.mindustry-wayland];
    persistence = util.persist {
      inherit config;
      directories = [".local/share/Mindustry"];
    };
  };
}

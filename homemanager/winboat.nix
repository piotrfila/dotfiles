{config, ...}: let
  util = import ../util.nix;
  unstable = import <nixos-unstable> {};
in {
  home = {
    packages = [
      unstable.winboat
    ];
    persistence = util.persist {
      inherit config;
      directories = [
        ".config/winboat"
        ".local/share/winboat"
        ".winboat"
      ];
    };
  };
}

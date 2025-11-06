{config, ...}: let
  util = import ../util.nix;
  unstable = import <nixos-unstable> {};
in {
  home.file = util.persist {
    inherit config;
    symlinks = [
      ".config/winboat"
      ".local/share/winboat"
      ".winboat"
    ];
  };
  home.packages = [
    unstable.winboat
  ];
}

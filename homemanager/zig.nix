{...}: let
  unstable = import <nixos-unstable> {};
in {
  home.packages = [
    unstable.zig
    unstable.zls
  ];
}

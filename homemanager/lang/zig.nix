{...}: let
  unstable = import <nixos-unstable> {};
in {
  home.packages = [
    unstable.zig_0_15
    unstable.zls
  ];
}

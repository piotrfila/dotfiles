{
  config,
  pkgs,
  ...
}: let
  unstable = import <nixos-unstable> {};
  util = import ../util.nix;
in {
  home.packages = with pkgs; [
    logisim-evolution
    gnome2.GConf
    gtkwave
    iverilog
    unstable.librelane
    unstable.openroad
    unstable.pdk-ciel
    verible
    verilator
    unstable.yosys
  ];
}

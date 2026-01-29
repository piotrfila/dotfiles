{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.packages = with pkgs; [
    logisim-evolution
    gnome2.GConf
    gtkwave
    iverilog
    verible
    verilator
  ];
}

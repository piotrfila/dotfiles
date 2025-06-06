{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  # home.file = util.persist {
  #   inherit config;
  #   symlinks = [ ];
  # };
  home.packages = [
    logisim-evolution
    gnome2.GConf
    gtkwave
    iverilog
    verible
    verilator
  ];
}

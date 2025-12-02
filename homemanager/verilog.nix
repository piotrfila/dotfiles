{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  # home.persistence = util.persist {
  #   inherit config;
  #   directories = [ ];
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

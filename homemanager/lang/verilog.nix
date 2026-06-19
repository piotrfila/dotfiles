{
  config,
  pkgs,
  ...
}: let
  util = import ../../util.nix;
in {
  home = {
    packages = with pkgs; [
      logisim-evolution
      gnome2.GConf
      gtkwave
      iverilog
      librelane
      openroad
      pdk-ciel
      verible
      verilator
      yosys
    ];
    persistence = util.persist {
      inherit config;
      directories = [".ciel"];
    };
  };
}

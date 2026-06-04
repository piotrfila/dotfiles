{
  config,
  pkgs,
  ...
}: let
  util = import ../../../util.nix;
in {
  home = {
    packages = [pkgs.qalculate-qt];
    persistence = util.persist {
      inherit config;
      files = [".config/qalculate"];
    };
  };
  wayland.windowManager.hyprland.settings = {
    exec-once = with pkgs; [
      "[workspace special:q silent] qalculate-gtk"
    ];
    windowrule = [
      {
        name = "qualculate";
        "match:class" = "(io.github.Qalculate.qalculate-)((qt)|(gtk))$";
        float = true;
        move = "(monitor_w*0.05) (monitor_h*0.10)";
        size = "(monitor_w*0.30) (monitor_h*0.80)";
      }
    ];
  };
}

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
        size = "30% 80%";
        move = "5% 10%";
      }
    ];
  };
}

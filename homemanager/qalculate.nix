{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.file = util.persist {
    inherit config;
    symlinks = [".config/qalculate"];
  };

  home.packages = [pkgs.qalculate-qt];

  wayland.windowManager.hyprland.settings = {
    exec-once = with pkgs; [
      "[workspace special:q silent] qalculate-gtk"
    ];
    windowrule = let
      name = "class:(io.github.Qalculate.qalculate-)((qt)|(gtk))$";
    in [
      "float,${name}"
      "size 30% 80%,${name}"
      "move 5% 10%,${name}"
    ];
  };
}

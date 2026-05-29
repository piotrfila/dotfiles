{pkgs, ...}: {
  home.packages = [pkgs.mission-center];
  wayland.windowManager.hyprland.settings.windowrule = let
    name = "match:class ^(io\.missioncenter\.MissionCenter)|(nm-connection-editor)|(\.blueman-manager-wrapped)$";
  in [
    "float on,${name}"
    "size 60% 60%,${name}"
    "move 35% 20%,${name}"
  ];
}

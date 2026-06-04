{pkgs, ...}: {
  home.packages = [pkgs.mission-center];
  wayland.windowManager.hyprland.settings.windowrule = [
    {
      name = "mission_center";
      "match:class" = "^(io\.missioncenter\.MissionCenter)|(nm-connection-editor)|(\.blueman-manager-wrapped)$";
      float = true;
      move = "(monitor_w*0.35) (monitor_h*0.20)";
      size = "(monitor_w*0.60) (monitor_h*0.60)";
    }
  ];
}

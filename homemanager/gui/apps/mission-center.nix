{pkgs, ...}: {
  home.packages = [pkgs.mission-center];
  wayland.windowManager.hyprland.settings.windowrule = [
    {
      name = "mission_center";
      "match:class" = "^(io\.missioncenter\.MissionCenter)|(nm-connection-editor)|(\.blueman-manager-wrapped)$";
      float = true;
      size = "60% 60%";
      move = "35% 20%";
    }
  ];
}

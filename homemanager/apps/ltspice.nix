{pkgs, ...}: {
  xdg.desktopEntries = {
    ltspice = let
      docs = "/home/kaliko/Documents/LTspiceXVII";
      ltspice_path = "/home/kaliko/.local/share/wine/drive_c/users/kaliko/AppData/Local/Programs/ADI/LTspice/";
    in {
      name = "LTspice";
      exec = "wine ${ltspice_path}LTspice.exe -ini ${docs}/keybinds.ini";
      terminal = false;
      icon = "${docs}/icon.jpg";
      categories = ["Application"];
    };
  };
  wayland.windowManager.hyprland.settings.windowrule = ["tile, title:^(LTspice)$"];
}

{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings.windowrule = [
    "tile, title:^(LTspice)$"
  ];
  xdg.desktopEntries = {
    ltspice = let
      docs = "${config.home.homeDirectory}/Documents/LTspiceXVII";
      c-drive = "${config.home.homeDirectory}/.local/share/wine/drive_c";
      appdata = "${c-drive}/users/${config.home.username}/AppData";
      ltspice_path = "${appdata}/Local/Programs/ADI/LTspice/";
    in {
      name = "LTspice";
      exec = "wine ${ltspice_path}LTspice.exe -ini ${docs}/keybinds.ini";
      terminal = false;
      icon = "${docs}/icon.jpg";
      categories = ["Application"];
    };
  };
}

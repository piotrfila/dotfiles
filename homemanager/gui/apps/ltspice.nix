{
  config,
  pkgs,
  ...
}: {
  imports = [./wine.nix];
  wayland.windowManager.hyprland.settings.windowrule = [
    {
      name = "ltspice";
      "match:title" = "^(LTspice)$";
      tile = true;
    }
  ];
  xdg.desktopEntries = {
    ltspice = let
      documents = "${config.home.homeDirectory}/Documents/LTspiceXVII";
      drive_c = "${config.xdg.dataHome}/wine/drive_c";
      exec_path = "${drive_c}/Program Files/ADI/LTspice/LTspice.exe";
    in {
      name = "LTspice";
      exec = "wine \"${exec_path}\" -ini \"${documents}/keybinds.ini\"";
      terminal = false;
      icon = "${documents}/icon.jpg";
      categories = ["Science"];
    };
  };
}

{config, ...}: let
  util = import ../util.nix;
in {
  home.file.".config/Thunar/uca.xml".text = ''
    <actions>
      <action>
        <icon>utilities-terminal</icon>
        <name>Open Terminal Here</name>
        <submenu/>
        <unique-id>1715452666870153-1</unique-id>
        <command>
        kitty %f
        </command>
        <description>Open Terminal Here</description>
        <range/>
        <patterns>*</patterns>
        <startup-notify/>
        <directories/>
      </action>
      <action>
        <icon>utilities-terminal</icon>
        <name>Open VSCodium Here</name>
        <submenu/>
        <unique-id>1715662666870153-1</unique-id>
        <command>
        codium %f
        </command>
        <description>Open VSCodium Here</description>
        <range/>
        <patterns>*</patterns>
        <startup-notify/>
        <directories/>
      </action>
    </actions>
  '';
  wayland.windowManager.hyprland.settings.windowrule = [
    "float,title:^(Confirm to replace files)$"
    "float,title:^(File Operation Progress)$"
  ];
}
